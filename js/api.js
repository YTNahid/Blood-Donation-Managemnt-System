// SESSION API
export const getSessionInfo = async () => {
  const res = await fetch('server/getSessionInfo.jsp');
  const data = await res.json();
  return data;
};

// USER API
export const getAllUsers = async () => {
  const res = await fetch(`server/getAllUsers.jsp`);
  const data = await res.json();
  return data;
};

export const getOneUser = async (user_id) => {
  const res = await fetch(`server/getOneUser.jsp?user_id=${user_id}`);
  const data = await res.json();
  return data;
};

export const getUserPasswordMatch = async (user_id, password) => {
  const res = await fetch(`server/getUserPasswordMatch.jsp?user_id=${user_id}&password=${encodeURIComponent(password)}`);
  const data = await res.json();
  return data;
};

export const getUserLocation = () => {
  return new Promise((resolve) => {
    if (!navigator.geolocation) {
      console.log('Geolocation not supported.');
      resolve(null);
    } else {
      navigator.geolocation.getCurrentPosition(
        (position) => {
          const { latitude, longitude } = position.coords;
          resolve({ latitude, longitude });
        },
        (error) => {
          console.warn('Geolocation error:', error);
          resolve(null);
        },
        {
          enableHighAccuracy: false,
          maximumAge: 1000 * 60 * 5,
        }
      );
    }
  });
};

// DELETE DATA FROM ANY TABLE
export const deleteData = async (id, columnName, tableName) => {
  const res = await fetch('server/deleteData.jsp', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: new URLSearchParams({ id, columnName, tableName }),
  });
  const data = await res.json();
  return data;
};

// Format Date
export const formatDate = (dateStr, time = true) => {
  const date = new Date(dateStr);
  if (!time) {
    const parts = date
      .toLocaleDateString('en-GB', {
        day: '2-digit',
        month: 'short',
        year: 'numeric',
      })
      .split(' ');
    return `${parts[0]} ${parts[1]}, ${parts[2]}`;
  }
  return date
    .toLocaleString('en-GB', {
      day: '2-digit',
      month: 'short',
      year: 'numeric',
      hour: 'numeric',
      minute: '2-digit',
      hour12: true,
    })
    .replace(' ', ', ');
};
