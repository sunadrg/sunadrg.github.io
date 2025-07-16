'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "4b29d99d7f3896320011f597cdeed041",
"assets/AssetManifest.bin.json": "c27291c254ffc34e331fe9b81875c836",
"assets/AssetManifest.json": "ad6cb62a59f31ddd534ef534860b96e4",
"assets/assets/fonts/Inter/Inter-Italic-VariableFont_opsz,wght.ttf": "6dce17792107f0321537c2f1e9f12866",
"assets/assets/fonts/Inter/Inter-VariableFont_opsz,wght.ttf": "0a77e23a8fdbe6caefd53cb04c26fabc",
"assets/assets/images/illustration.svg": "1528eb59e9d6dec8a62eacd09635906a",
"assets/assets/images/skills/android-original.svg": "3f0a9233bf0d7d9a02e0f08b94bce2cd",
"assets/assets/images/skills/androidstudio-original.svg": "f45824a5ae74092cba63532b26c45518",
"assets/assets/images/skills/apache-original.svg": "b554392c1ab84edbcd1970be428714bb",
"assets/assets/images/skills/apple-original.svg": "51f73ac01c1ddbd4e219d1bb22fbcfd2",
"assets/assets/images/skills/canva-original.svg": "d73d3bed607c7763601a870b37b97ddd",
"assets/assets/images/skills/cicd-custom.svg": "0b74426b011afaaf922e7f6e05e54f22",
"assets/assets/images/skills/css3-original.svg": "a55118403c13e2719d453b74dffa80f8",
"assets/assets/images/skills/dart-original.svg": "11b770f163584b0e8cbba1f7bc626f55",
"assets/assets/images/skills/dart.svg": "9bdebce5ff1d66b398d9ffccd878a5e3",
"assets/assets/images/skills/firebase-original.svg": "e49de29322e84ba9bef16c93af22891d",
"assets/assets/images/skills/flutter-original.svg": "5ff1722cbed36fdb869cba0c95788d42",
"assets/assets/images/skills/git-original.svg": "fef8e95112e6ab6f2169430ee510db5e",
"assets/assets/images/skills/github-original.svg": "4b8a4845e3c03b05cc92e2b3199889d5",
"assets/assets/images/skills/google-play_5.svg": "d94e559e27ed25a32de138fba0f26a5d",
"assets/assets/images/skills/gradle-original.svg": "4037d67fbfe5726dcb62efa1a2276c81",
"assets/assets/images/skills/html5-original.svg": "16d07e8682a531f3bc1e9fb01bd59740",
"assets/assets/images/skills/ios-original.svg": "4dbf7eca8b5f2a4fb0a6f44e9881ca11",
"assets/assets/images/skills/java-original.svg": "459bbae2e96a2410c5b429eb941a4c11",
"assets/assets/images/skills/javascript-original.svg": "0c1f700da144243c526f252e59362138",
"assets/assets/images/skills/kotlin-original.svg": "df64e60cd6f3e98007374fd721c4cc1b",
"assets/assets/images/skills/linkedin-plain.svg": "48a406d5c052f8db83514425edc122b1",
"assets/assets/images/skills/materialui-original.svg": "de2fef3601923126903c9a383d786e20",
"assets/assets/images/skills/mvc-custom.svg": "d4d1623c9633c162553a27dafc599f48",
"assets/assets/images/skills/mvvm-custom.svg": "5ed4a43216b282f431a62453699cc0f3",
"assets/assets/images/skills/mysql-original.svg": "e8eb3c35a4724c59933bb8b80b402586",
"assets/assets/images/skills/php-original.svg": "2d61a3b7505e53fa3185bdf8da7b6f8e",
"assets/assets/images/skills/retrofit-custom.svg": "7d848f394f82a7a46777e15a4ffad81a",
"assets/assets/images/skills/volley-custom.svg": "b3ec5b7e68e1dcb5c46efd823195a322",
"assets/assets/images/skills/vscode-original-wordmark.svg": "2864e4e0c25c206406dcd786f309dcb8",
"assets/assets/images/skills/web-original.svg": "e45f5b34e7c5ab84bdcb7c34de411cf0",
"assets/assets/images/skills/xml-original.svg": "48958bdbe7d7ac0343d1b6e5ef798b6f",
"assets/assets/images/sunad.jpeg": "2116b2d858a1a18fc2926552cf1500e8",
"assets/assets/projects.json": "7896b92c8560c991d27560039fc6e918",
"assets/assets/sunad_cv.pdf": "a2ba70a41a9d717b52eb2a6371c7c317",
"assets/FontManifest.json": "3c09e530dd53c3a4c7bafdb3eb7d15dc",
"assets/fonts/MaterialIcons-Regular.otf": "3ee68ef1980e36edf73b58b12b1b1f50",
"assets/NOTICES": "2c9549c3d913e94d62036ef587986f02",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "f4c9e9f5cd21486c05ac8b6f3bbf1adf",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "326f4a0ff00d740c85137975562841ab",
"/": "326f4a0ff00d740c85137975562841ab",
"main.dart.js": "50b01fe7bbaf2673c944abdd95519cab",
"manifest.json": "1f669504dbbe32938cdf975a493d24dc",
"version.json": "a1f3fb16d9290b637dc368abe87ef2e4"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
