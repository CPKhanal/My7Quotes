const cacheName = 'my7quotes-v1';
const staticAssets = [
  './',
  './index.html',
  './about.html',
  './archive.html',
  './privacy.html',
  './quotes.json',
  './data.json'
];

// Install: Cache all important files
self.addEventListener('install', async e => {
  const cache = await caches.open(cacheName);
  await cache.addAll(staticAssets);
  return self.skipWaiting();
});

// Activate: Clean up old caches
self.addEventListener('activate', e => {
  self.clients.claim();
});

// Fetch: Serve from cache if offline
self.addEventListener('fetch', async e => {
  const req = e.request;
  const url = new URL(req.url);

  if (url.origin === location.origin) {
    e.respondWith(cacheFirst(req));
  } else {
    e.respondWith(networkAndCache(req));
  }
});

async function cacheFirst(req) {
  const cache = await caches.open(cacheName);
  const cached = await cache.match(req);
  return cached || fetch(req);
}

async function networkAndCache(req) {
  const cache = await caches.open(cacheName);
  try {
    const refresh = await fetch(req);
    await cache.put(req, refresh.clone());
    return refresh;
  } catch (e) {
    const cached = await cache.match(req);
    return cached;
  }
}
