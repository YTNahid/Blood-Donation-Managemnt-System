import { getSessionInfo, deleteData, formatDate } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	// Post Announcement Form Submission
	const announcementForm = document.getElementById('announcementForm');
	if (announcementForm) {
		announcementForm.addEventListener('submit', async (e) => {
			e.preventDefault();

			const session = await getSessionInfo();

			const formData = new URLSearchParams(new FormData(announcementForm));
			formData.append('user_id', session.user_id);

			const response = await fetch('server/postAdminAnnouncement.jsp', {
				method: 'POST',
				headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
				body: formData.toString()
			});

			const result = await response.json();

			if (result.success) {
				alert(result.message);
				announcementForm.reset();
				window.location.href = 'announcements.jsp';
			} else {
				alert(result.message);
				console.error(result.error);
			}
		});
	}


	// SHow Announcements
	const session = await getSessionInfo();

	const response = await fetch('server/getAnnouncements.jsp');
	const result = await response.json();

	renderAnnouncements(result.announcements, session.role);
});

const renderAnnouncements = (announcements, role) => {
	const container = document.getElementById('announcements-list');
	if (!container) return;

	if (!announcements.length) {
		container.innerHTML = '<p class="text">No announcements available at the moment.</p>';
		return;
	}
	container.innerHTML = announcements.map(a => `
			<div class="announcement data">
				${role === 'admin' ? `<img src="assets/trash-solid-full.svg" class="delete-data" data-id="${a.announcement_id}" data-table="announcements" data-column="announcement_id" alt="Delete">` : ''}
				<h4 class="heading title">${a.title}</h4>
				<div class="meta">
					<span class="date"><span class="posted-by">Posted by: <b>${a.posted_by || 'Unknown'}</b></span> on ${formatDate(a.post_date)}</span>
				</div>
				<div class="content">${a.message}</div>
			</div>
		`).join('');

	document.querySelectorAll('.delete-data').forEach(btn => {
		btn.addEventListener('click', async () => {
			if (!confirm('Are you sure you want to delete this announcement?')) return;
			const { id, column, table } = btn.dataset;
			const result = await deleteData(id, column, table);
			alert(result.message);

			btn.closest('.announcement').remove();
		});
	});
}