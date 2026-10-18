const serviceWorkerUrl = new URL('sw.js', document.currentScript.src);

if ('serviceWorker' in navigator) {
    window.addEventListener('load', () => {
        navigator.serviceWorker.register(serviceWorkerUrl);
    });
}