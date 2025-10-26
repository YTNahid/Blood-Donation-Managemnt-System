import { getSessionInfo, deleteData, getAllUsers, formatDate } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
  const container = document.getElementById('history-list');

  if (container) {
    const session = await getSessionInfo();

    const res = await fetch(`server/getHistories.jsp`);
    const data = await res.json();

    console.log(data.results);

    renderHistory(data.results, session.role);
  }

  const form = document.getElementById('historyForm');

  if (form) {
    const donorSelect = document.getElementById('donor_id');
    const res = await fetch('server/getAllUsers.jsp');
    const data = await res.json();

    donorSelect.innerHTML =
      '<option value="">-- Select Donor --</option>' +
      data.results.map((u) => `<option value="${u.user_id}">${u.user_id} - ${u.username}</option>`).join('');

    form.addEventListener('submit', async (e) => {
      e.preventDefault();

      const formData = new URLSearchParams(new FormData(form));

      const response = await fetch(`server/postAdminDonationHistory.jsp?${formData.toString()}`);

      const result = await response.json();

      if (result.success) {
        alert(result.message);
        form.reset();
      } else {
        alert(result.message || 'Failed to add history.');
        console.error(result.error);
      }
    });
  }
});

const renderHistory = (histories, role) => {
  const container = document.getElementById('history-list');

  if (!histories.length) {
    container.innerHTML = '<p class="text">No history found.</p>';
    return;
  }

  // Split histories by status
  const pending = histories.filter((h) => h.status === 'pending');
  const approved = histories.filter((h) => h.status === 'approved');

  // Section 1: Pending table (only if admin)
  let pendingSection = '';
  if (role === 'admin') {
    const pendingTable = pending.length
      ? `
        <div class="table-container">
          <table class="pending-table">
            <thead>
              <tr>
                <th>Request ID</th>
                <th>Username</th>
                <th>Action</th>
                <th>Date</th>
                <th>Decision</th>
              </tr>
            </thead>
            <tbody>
              ${pending
                .map(
                  (h) => `
                  <tr>
                    <td>${h.request_id}</td>
                    <td>${h.username}</td>
                    <td>${h.action}</td>
                    <td>${formatDate(h.donation_date, false)}</td>
                    <td>
                      <button class="button button-small approveBtn decisionBtn" data-id="${h.donation_id}">Approve</button>
                      <button class="button button-small button-delete decisionBtn" data-id="${h.donation_id}">Reject</button>
                    </td>
                  </tr>
                `
                )
                .join('')}
            </tbody>
          </table>
        </div>
      `
      : '<p>No pending requests.</p>';

    pendingSection = `
      <div class="pending-section">
        <h4 class="heading title">Pending Requests</h4>
        ${pendingTable}
      </div>
    `;
  }

  // Section 2: Approved history
  const approvedList = approved.length
    ? `
      ${approved
        .map(
          (h) => `
          <div class="data history">
            ${
              role === 'admin'
                ? `<img src="assets/trash-solid-full.svg" class="delete-data" data-id="${h.donation_id}" data-table="donation_history" data-column="donation_id" alt="Delete">`
                : ''
            }
            <p class="text history-content">
              <strong>${h.username}</strong> 
              ${h.action === 'donated' ? `<span style="color: purple;">donated blood</span>` : `<span style="color: blue;">received blood</span>`} 
              on ${formatDate(h.donation_date, false)}
            </p>
          </div>
        `
        )
        .join('')}
    `
    : '<p>No approved history yet.</p>';

  // Combine sections
  container.innerHTML = `
    ${pendingSection}
    <div class="approved-section">
      <h4 class="heading title">Approved History</h4>
      ${approvedList}
    </div>
  `;

  // Delete button logic
  document.querySelectorAll('.delete-data').forEach((btn) => {
    btn.addEventListener('click', async () => {
      if (!confirm('Are you sure you want to delete this history?')) return;
      const { id, column, table } = btn.dataset;
      const result = await deleteData(id, column, table);
      if (result.success) {
        alert(result.message);
        btn.closest('.history').remove();
      } else {
        alert(result.message || 'Failed to delete history.');
        console.error(result.error);
      }
    });
  });

  // Approve/Reject button logic (static for now)
  const decisionBtn = document.querySelectorAll('.decisionBtn');

  decisionBtn.forEach((btn) => {
    btn.addEventListener('click', async () => {
      const donationId = btn.dataset.id;
      const decision = btn.textContent.toLowerCase() === 'approve' ? 'approved' : 'rejected';

      const response = await fetch(`server/updateDonatedOrReceived.jsp?donation_id=${donationId}&decision=${decision}`);
      const result = await response.json();

      if (result.success) {
        alert(result.message);
        location.reload();
      } else {
        alert(result.message || 'Failed to approve request.');
        console.error(result.error);
      }
    });
  });
};
