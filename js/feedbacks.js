import { getSessionInfo, deleteData, formatDate } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
  const session = await getSessionInfo();

  const response = await fetch('server/getFeedbacks.jsp');
  const data = await response.json();

  console.log(data.results);

  if (data.success) {
    renderFeedbacks(data.results || [], session.role);
  } else {
    renderFeedbacks([]);
  }
});

const renderFeedbacks = (feedbacks, role) => {
  const container = document.getElementById('feedbacks-list');
  console.log(feedbacks);
  if (!container) return;

  if (!feedbacks.length) {
    container.innerHTML = '<p class="text">No feedbacks found.</p>';
    return;
  }
  container.innerHTML = feedbacks
    .map(
      (f) => `
        <div class="data feedback">
            ${
              role === 'admin'
                ? `<img src="assets/trash-solid-full.svg" class="delete-data" data-id="${f.message_id}" data-table="contact_form" data-column="message_id" alt="Delete">`
                : ''
            }
            <p class="text meta">${formatDate(f.submitted_at)}</p>
            <p class="text name"><b>From:</b> ${f.name || ''} ${f.contacted_by ? '' : '(Guest)'}</p>
            <p class="text email"><b>Email:</b> ${f.email || ''}</p>
            <p class="text subject"><b>Subject:</b> ${f.subject || ''}</p>
            <p class="text message"><b>Message:</b> <br> ${f.message || ''}</p>
        </div>
    `
    )
    .join('');

  document.querySelectorAll('.delete-data').forEach((btn) => {
    btn.addEventListener('click', async () => {
      if (!confirm('Are you sure you want to delete this feedback?')) return;
      const { id, column, table } = btn.dataset;
      const result = await deleteData(id, column, table);
      alert(result.message);

      btn.closest('.feedback').remove();
    });
  });
};
