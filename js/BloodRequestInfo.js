import { getUserLocation, deleteData, formatDate, getSessionInfo } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
  const bloodRequestPage = document.getElementById('blood-request-page');

  if (bloodRequestPage) {
    const filterForm = document.getElementById('filterForm');
    if (filterForm) {
      filterForm.addEventListener('submit', (e) => {
        e.preventDefault();
      });
    }
    // SHow Blood Requests based on filters
    const bloodGroupSelect = document.getElementById('bloodGroupSelect');
    const ownCheckbox = document.getElementById('ownCheckbox');
    const nearbyCheckbox = document.getElementById('nearbyCheckbox');
    const urgentCheckbox = document.getElementById('urgentCheckbox');
    const searchRequestId = document.getElementById('searchRequestId');

    // Trigger filtering on every keystroke
    searchRequestId.addEventListener('input', () => {
      applyFilters();
    });

    const applyFilters = async () => {
      const bloodGroup = bloodGroupSelect.value;
      const showOwn = ownCheckbox.checked;
      const showNearby = nearbyCheckbox.checked;
      const urgentOnly = urgentCheckbox.checked;
      const requestId = searchRequestId.value;

      let location = await getUserLocation();

      const params = new URLSearchParams();
      if (location && location.latitude && location.longitude) {
        params.append('latitude', location.latitude);
        params.append('longitude', location.longitude);
      }
      if (bloodGroup) params.append('blood_group', bloodGroup);
      if (showOwn) params.append('own', 'true');
      if (showNearby) params.append('nearby', 'true');
      if (urgentOnly) params.append('urgent', 'true');
      if (requestId) params.append('searchRequestId', requestId);

      fetchRequests(params);
    };

    bloodGroupSelect.onchange = applyFilters;
    ownCheckbox.onchange = applyFilters;
    nearbyCheckbox.onchange = applyFilters;
    urgentCheckbox.onchange = applyFilters;

    if (window.location.search.includes('nearby=true')) {
      nearbyCheckbox.checked = true;
      applyFilters();
    }

    applyFilters();
  }

  // Post Blood Requests
  const form = document.getElementById('bloodRequestForm');

  if (form) {
    form.addEventListener('submit', async (e) => {
      e.preventDefault();

      const formData = new URLSearchParams(new FormData(form));

      const res = await fetch(`server/postBloodRequest.jsp?${formData.toString()}`);
      const result = await res.json();

      if (result.success) {
        alert(result.message);
        form.reset();
      } else {
        alert(result.message || 'Failed to post request.');
        console.error('Error response:', result.error);
      }
    });
  }
});

const fetchRequests = async (params) => {
  try {
    showLoadingMessage();

    const url = `server/getBloodRequestInfo.jsp?${params.toString()}`;

    const res = await fetch(url);
    const data = await res.json();

    if (data.error) {
      console.error(data.error);
      renderRequests([]);
      return;
    }

    let allRequests = data.results || [];

    renderRequests(allRequests);
  } catch (e) {
    console.error('Failed to fetch requests:', e.message);
    renderRequests([]);
  }
};

function renderRequests(requests) {
  const container = document.getElementById('blood-requests-list');
  if (!container) return;

  if (!requests.length) {
    container.innerHTML = '<p class="text">No blood requests found.</p>';
    return;
  }

  container.innerHTML = requests
    .map(
      (r) => `
	    <div class="request data">
			${
        r.current_user_role === 'admin' || r.requester_id == r.current_user_id
          ? `
			    <img src="assets/trash-solid-full.svg" 
			         class="delete-data"
			         data-id="${r.request_id}" 
			         data-column="request_id" 
			         data-table="blood_requests">
			`
          : ''
      }
	        <h4 class="heading title">
	            ${r.blood_group} Blood Needed ${r.urgent ? `<span class="urgent-msg"> (Urgent)</span>` : ''}
	        </h4>
	        <div class="meta">
	            <span>By <strong>${r.requester_username}</strong> on ${r.request_date ? formatDate(r.request_date) : ''} | <strong>ID: ${
        r.request_id
      }</strong></span>
	        </div>
	        <div class="blood-request-content">
	            <p class="text"><strong>Location:</strong> ${r.location}</p>
	            <p class="text"><strong>District:</strong> ${r.district || ''}</p>
	            <p class="text"><strong>Contact Info:</strong> ${r.contact_info}</p>
				<p class="text"><strong>Due Date:</strong> ${formatDate(r.due_date, false)}</p>
	            <p class="text"><strong>Reason:</strong> ${r.reason}</p>
	            ${
                r.latitude && r.longitude
                  ? `
	                <div class="row exclude location-link">
	                    <a href="https://www.google.com/maps/search/?api=1&query=${r.latitude},${r.longitude}" target="_blank">
	                        <button class="button button-small">View Location</button>
	                    </a>
	                    ${typeof r.distance === 'number' ? ` (${r.distance.toFixed(2)} Km away)` : ''}
	                </div>`
                  : ''
              }
              <div class="note">*Click the button bellow if you have donated or received blood*</div>
              <div class="row exclude action">
                  <button class="button button-small actionBtn ${r.current_user_id === r.requester_id ? 'received' : 'donated'}" data-request-id=${
        r.request_id
      }>${r.current_user_id === r.requester_id ? 'Received' : 'Donated'}</button>
                  <span class="status">${r.status ? r.status : ''}</span>
              </div>
	        </div>
	    </div>
	`
    )
    .join('');

  // Delete Blood Request
  document.querySelectorAll('.delete-data').forEach((btn) => {
    btn.addEventListener('click', async () => {
      if (!confirm('Are you sure you want to delete this request?')) return;
      const { id, column, table } = btn.dataset;
      const result = await deleteData(id, column, table);
      alert(result.message);

      btn.closest('.request').remove();
    });
  });

  // Donated or Received Action Buttons
  const actionBtn = document.querySelectorAll('.actionBtn');
  if (actionBtn) {
    actionBtn.forEach((btn) => {
      checkStatus(btn.dataset.requestId, btn);

      btn.addEventListener('click', async () => {
        const session = await getSessionInfo();

        // If user is not logged in, redirect to login page
        if (!session.user_id) {
          window.location.href = 'login.jsp';
          return;
        }

        // If logged in, proceed with the action
        const actionText = btn.textContent.toLowerCase().trim();
        const params = new URLSearchParams();
        params.append('requestId', btn.dataset.requestId);
        params.append('action', actionText);
        params.append('donor_id', session.user_id);

        let response = await fetch(`server/postDonatedOrReceived.jsp?${params.toString()}`);
        let result = await response.json();

        if (result.success) {
          alert(result.message);
          checkStatus(btn.dataset.requestId, btn);
        } else {
          alert(result.message || 'Failed to submit action.');
          console.error('Error response:', result.error);
        }
      });
    });
  }
}

const checkStatus = async (requestId, btn) => {
  const response = await fetch(`server/getDonationHistoryByRequestId.jsp?requestId=${requestId}`);
  const result = await response.json();

  console.log(result);

  if (result.success && Array.isArray(result.results)) {
    const session = await getSessionInfo();

    // 1. Look for pending
    const pending = result.results.find((r) => r.status === 'pending');

    // 2. Look for approved
    const approved = result.results.find((r) => r.status === 'approved');

    // 3. Look for rejected (two cases)
    const rejectedForEveryone = result.results.find((r) => r.status === 'rejected' && r.action === 'received');

    const rejectedForDonor = result.results.find((r) => r.status === 'rejected' && r.action === 'donated' && r.donor_id === session.user_id);

    let recordToShow = null;

    if (pending) {
      recordToShow = pending;
      btn.disabled = true;
    } else if (approved) {
      recordToShow = approved;
      btn.disabled = true;
    } else if (rejectedForEveryone) {
      recordToShow = rejectedForEveryone;
      btn.disabled = true;
    } else if (rejectedForDonor) {
      recordToShow = rejectedForDonor;
      btn.disabled = true;
    }

    if (recordToShow) {
      const status = recordToShow.status;
      console.log('Status:', status);

      const statusContainer = btn.parentElement.querySelector('.status');
      if (statusContainer) {
        statusContainer.textContent = status === 'approved' ? 'Complete' : status.toUpperCase();
        statusContainer.classList.add(status);
      }

      // If not admin and delete-data exists, remove it
      if (session.role !== 'admin') {
        const requestEl = btn.closest('.request');
        if (requestEl && requestEl.querySelector('.delete-data')) {
          requestEl.querySelector('.delete-data').remove();
        }
      }
    }
  }
};

function showLoadingMessage() {
  const container = document.getElementById('blood-requests-list');
  if (container) {
    container.innerHTML = '<p class="text">Loading Requests...</p>';
  }
}
