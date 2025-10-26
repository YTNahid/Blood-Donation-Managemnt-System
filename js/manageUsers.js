import { getAllUsers, deleteData } from './api.js';

document.addEventListener('DOMContentLoaded', async () => {
	try {
		// Fetch all users from API
		const data = await getAllUsers();
		const users = data.results || {}

		// Separate admins and normal users
		const admins = users.filter(u => u.role && u.role.toLowerCase() === 'admin');
		const normalUsers = users.filter(u => !u.role || u.role.toLowerCase() !== 'admin');

		// Render tables
		renderAdmins(admins);
		renderUsers(normalUsers);

	} catch (err) {
		console.error('Error fetching users:', err);
	}
});

const renderAdmins = (admins) => {
	// Render Admins Table
	const adminTbody = document.querySelector('.admins-section tbody');
	if (adminTbody) {
		adminTbody.innerHTML = admins.map(admin => `
            <tr class="user-row">
                <td>${admin.user_id}</td>
                <td>${admin.username}</td>
                <td>${admin.email}</td>
                <td>${admin.phone || ''}</td>
                <td>${admin.district || ''}</td>
                <td>
                    <a href="userDetails.jsp?user_id=${admin.user_id}">
                        <button class="button button-small">View Profile</button>
                    </a>
                    <form method="post" action="server/updateRole.jsp" style="display: inline;">
                        <input type="hidden" name="user_id" value="${admin.user_id}" />
                        <input type="hidden" name="new_role" value="user" />
                        <button type="submit" class="button button-small">Make User</button>
                    </form>
                    <form style="display: inline;">
                        <input type="hidden" name="user_id" value="${admin.user_id}" />
                        <button type="submit" class="button button-small delete" data-id="${admin.user_id}" data-table="users" data-column="user_id">Delete</button>
                    </form>
                </td>
            </tr>
        `).join('');
	}

	document.querySelectorAll('.delete').forEach(btn => {
		btn.addEventListener('click', async () => {
			if (!confirm('Are you sure you want to delete this user?')) return;
			const { id, column, table } = btn.dataset;
			
			const result = await deleteData(id, column, table);
			
			if (result.success) {
				alert(result.message);
				btn.closest('.user-row').remove();
			} else {
				alert(result.message || 'Failed to delete user.');
				console.error(result.error);
			}
		});
	});
};

const renderUsers = (users) => {
	const userTbody = document.querySelector('.users-section tbody');
	if (userTbody) {
		userTbody.innerHTML = users.map(user => `
            <tr class="user-row">
                <td>${user.user_id}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.phone || ''}</td>
                <td>${user.district || ''}</td>
                <td>
                    <a href="userDetails.jsp?user_id=${user.user_id}">
                        <button class="button button-small">View Profile</button>
                    </a>
					
                    <form method="post" action="server/updateRole.jsp" style="display: inline;">
                        <input type="hidden" name="user_id" value="${user.user_id}" />
                        <input type="hidden" name="new_role" value="admin" />
                        <button type="submit" class="button button-small">Make Admin</button>
                    </form>
					
                    <button class="button button-small delete" data-id="${user.user_id}" data-table="users" data-column="user_id">Delete</button>
                </td>
            </tr>
        `).join('');
	}

	document.querySelectorAll('.delete').forEach(btn => {
		btn.addEventListener('click', async () => {
			if (!confirm('Are you sure you want to delete this user?')) return;
			const { id, column, table } = btn.dataset;

			const result = await deleteData(id, column, table);

			console.log(result);

			if (result.success) {
				alert(result.message);
				btn.closest('.user-row').remove();
			} else {
				alert(result.message || 'Failed to delete user.');
				console.error(result.error);
			}
		});
	});
};
