document.addEventListener('DOMContentLoaded', async () => {
	const bloodGroupSelect = document.getElementById('bloodGroupSelect');
	const districtSelect = document.getElementById('districtSelect');

	const applyFilters = async () => {
		const bloodGroup = bloodGroupSelect.value;
		const district = districtSelect.value;

		const params = new URLSearchParams();

		if (bloodGroup) params.append("blood_group", bloodGroup);
		if (district) params.append("district", district);

		fetchDonors(params);
	};

	bloodGroupSelect.onchange = applyFilters;
	districtSelect.onchange = applyFilters;

	applyFilters();
});

const fetchDonors = async (params) => {
	try {
		showLoadingMessage();

		const url = `server/getDonors.jsp?${params.toString()}`;

		const res = await fetch(url);
		const data = await res.json();

		if (data.error) {
			console.error(data.error);
			renderDonors([]);
			return;
		}

		let allDonors = data.results || [];

		renderDonors(allDonors);
	} catch (e) {
		console.error("Failed to fetch requests:", e.message);
		renderDonors([]);
	}
}

function renderDonors(donors) {
	const container = document.getElementById('donors-list');
	if (!container) return;

	if (!donors.length) {
		container.innerHTML = '<p class="text">No donor found</p>';
		return;
	}

	container.innerHTML = `
		<div class="table-container">
			<table>
				<thead>
					<tr>
						<th>Name</th>
						<th>Blood Group</th>
						<th>Phone</th>
						<th>District</th>
						<th>More Contacts</th>
					</tr>
				</thead>
				<tbody>
					${donors.map(d => `
						<tr>
							<td>${d.username || ''}</td>
							<td>${d.blood_group || ''}</td>
							<td>${d.phone ? `<a href="tel:${d.phone}">${d.phone}</a>` : ''}</td>
							<td>${d.district || ''}</td>
							<td class="contact">
								${d.email ? `<a href="mailto:${d.email}"><img src="assets/envelope-solid-full.svg" class="icon"></a>` : ''}
								${d.whatsapp ? `<a href="https://wa.me/${d.whatsapp}" target="_blank"><img src="assets/whatsapp-brands-solid-full.svg" class="icon"></a>` : ''}
							</td>
						</tr>
					`).join('')}
				</tbody>
			</table>
		</div>
	`;
}

function showLoadingMessage() {
	const container = document.getElementById('blood-requests-list');
	if (container) {
		container.innerHTML = '<p class="text">Loading Requests...</p>';
	}
}