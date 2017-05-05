import 'whatwg-fetch';

export default async (
  method,
  path,
  body = {},
  headers = {},
) => {
  const options = (() => {
    const opt = {
      method,
      headers,
    };
    if (Object.keys(body).length !== 0) {
      Object.assign(opt, {
        body: JSON.stringify(body),
      });
    }
    return opt;
  })();

  const res = await fetch(`http://127.0.0.1:8080${path}`, options);
  let data = '';
  try {
    data = await res.json();
  } catch (_err) {
    data = '';
  }
  if (!res.ok) {
    throw new Error({
      code: res.status,
      data,
    });
  }
  return data;
};
