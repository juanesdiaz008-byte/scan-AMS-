# DAKOTA Tournament Integrity

Portal estático para registros de torneo y revisión manual. La base de datos está preparada para Supabase; GitHub Pages publica los archivos estáticos, pero no ejecuta un servidor ni guarda datos por sí mismo.

## Activar almacenamiento en Supabase

1. Crea un proyecto en [Supabase](https://supabase.com/) y abre **SQL Editor**.
2. Ejecuta el contenido de [`supabase/schema.sql`](supabase/schema.sql). Esto crea las tablas y políticas de seguridad: los participantes pueden enviar un registro con consentimiento; solo organizadores incluidos en una lista autorizada pueden leerlos.
3. En **Authentication → Users**, crea la cuenta del organizador. Desactiva los registros públicos de usuarios en la configuración de Authentication.
4. Copia el UUID de esa cuenta y autorízala desde SQL Editor, reemplazando el valor:

   ```sql
   insert into public.tournament_organizers (user_id)
   values ('UUID-DE-LA-CUENTA-AUTORIZADA');
   ```

5. En Supabase, copia **Project URL** y la clave **anon/public** (no uses `service_role`). Sustituye `SUPABASE_URL` y `SUPABASE_ANON_KEY` al final de `integrity.html`.
6. Guarda los cambios en `main`. GitHub Actions desplegará la página en GitHub Pages. La URL será `https://juanesdiaz008-byte.github.io/scan-AMS-/integrity.html`.
7. Prueba primero con datos ficticios: envía un registro y comprueba que solo la cuenta autorizada puede verlos en la pestaña **Organizador**.

La clave anon/public está diseñada para estar en el navegador; la seguridad depende de las políticas RLS incluidas. **Nunca publiques la clave `service_role`**, una contraseña ni otros secretos en HTML o GitHub. La página necesita conexión a internet para cargar el cliente de Supabase.

## Datos, privacidad y límites

Se guardan el nombre de usuario de Roblox, código del torneo, plataforma declarada voluntariamente, nota opcional, consentimiento y fecha. No se piden contraseñas, cookies ni tokens. La plataforma declarada no se verifica. No se inspecciona el dispositivo ni se detectan trampas. Las observaciones requieren revisión humana; no son prueba automática.

El propietario del proyecto es responsable de informar a los participantes, restringir las cuentas organizadoras, definir un plazo de conservación y atender solicitudes de eliminación. No se almacenan datos de participantes en este repositorio. La política permite enviar registros, pero no leerlos públicamente, modificarlos ni borrarlos desde el navegador.

El endpoint público de registro puede recibir spam; esta configuración inicial no incorpora CAPTCHA ni límites de frecuencia. Para un torneo con uso amplio, añade protección antiabuso y una política de retención antes de recopilar datos reales.
