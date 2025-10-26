// api.js
// Function to get session info from the backend
export async function getSessionInfo() {
    const response = await fetch('/server/getSessionInfo.jsp', {
        credentials: 'include', // send cookies for session
    });
    if (!response.ok) {
        throw new Error('Failed to fetch session info');
    }
    return await response.json();
}
