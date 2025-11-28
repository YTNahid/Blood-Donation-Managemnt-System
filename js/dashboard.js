document.addEventListener('DOMContentLoaded', () => {
	loadDashboardStats();
	renderRecentDonors();
});

// Animate number from start to end over duration (ms)
const animateValue = (element, start, end, duration) => {
    let startTime = null;

    const step = (timestamp) => {
        if (!startTime) startTime = timestamp;
        const progress = Math.min((timestamp - startTime) / duration, 1);
        element.textContent = Math.floor(progress * (end - start) + start);
        if (progress < 1) {
            requestAnimationFrame(step);
        }
    };

    requestAnimationFrame(step);
};

const loadDashboardStats = async () => {
    try {
        const res = await fetch('server/getDashboardStats.jsp');
        const data = await res.json();

        if (data.error) {
            console.error("Error fetching stats:", data.error);
            return;
        }

        animateValue(document.getElementById('total-donors'), 0, data.totalDonors ?? 0, 200);
        animateValue(document.getElementById('total-donations'), 0, data.totalDonations ?? 0, 200);
        animateValue(document.getElementById('total-requests'), 0, data.totalRequests ?? 0, 200);

    } catch (err) {
        console.error("Failed to load dashboard stats:", err);
    }
};


// Recent donors
const renderRecentDonors = async () => {
	const tbody = document.getElementById('recent-donors-body');
	if (!tbody) return;

	tbody.innerHTML = `<tr><td colspan="5">Loading recent donors...</td></tr>`;

	try {
		const res = await fetch('server/getRecentDonors.jsp');
		const donors = await res.json();

		if (donors.length && donors[0].error) {
			console.error("Error fetching donors:", donors[0].error);
			tbody.innerHTML = `<tr><td colspan="5">Error loading donors</td></tr>`;
			return;
		}

		if (!donors.length) {
			tbody.innerHTML = `<tr><td colspan="5">No donors found</td></tr>`;
			return;
		}

		tbody.innerHTML = donors.map(donor => `
		    <tr>
		        <td>${donor.name}</td>
		        <td>${donor.bloodGroup}</td>
		        <td><a href="tel:${donor.phone}">${donor.phone}</a></td>
		        <td>${donor.district || ''}</td>
		        <td class="contact">
		            <a href="mailto:${donor.email}">
		                <img src="assets/envelope-solid-full.svg" class="icon">
		            </a>
		            ${donor.whatsapp ? `
		                <a href="https://wa.me/${donor.whatsapp}" target="_blank">
		                    <img src="assets/whatsapp-brands-solid-full.svg" class="icon">
		                </a>` : ''}
		        </td>
		    </tr>
		`).join('');

	} catch (err) {
		console.error("Failed to load recent donors:", err);
		tbody.innerHTML = `<tr><td colspan="5">Error loading donors</td></tr>`;
	}
}