# DAKOTA Tournament Integrity

Portal estático para organizar registros y revisiones manuales en torneos de Roblox.

## Demo

- Portal original: `index.html`
- Registro transparente y revisión local: `integrity.html`
- Con GitHub Pages activo, la demo nueva estará en `https://juanesdiaz008-byte.github.io/scan-AMS-/integrity.html`.

## Alcance y privacidad

La demo permite registrar un nombre de usuario, código de torneo, plataforma/launcher declarada voluntariamente y una nota opcional. Los datos se mantienen solo en memoria durante la sesión de la página: no hay backend ni se transmiten o persisten. No solicites contraseñas, cookies, tokens ni otros secretos.

No detecta trampas, no identifica procesos/launchers en ejecución, no escanea archivos o memoria y no inspecciona Windows. Una página estática no puede realizar estas comprobaciones de manera fiable. Cualquier observación debe revisarse por una persona; una alerta aislada no demuestra una infracción.

La vista de organizador es una demostración local, no tiene autenticación y no debe usarse con datos sensibles ni como sistema real de sanciones.

## Publicación

El workflow de GitHub Actions publica el contenido del repositorio en GitHub Pages al actualizar `main`. Tras el despliegue, abre la URL indicada arriba.
