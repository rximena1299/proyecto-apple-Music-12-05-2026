# 📱 Plan de Implementación: Aplicación "Amazon Compras"

> 📌 **Nota preliminar:** Este documento es un **plan estratégico y procedimental**. No contiene fragmentos de código. Está diseñado para guiar el desarrollo de forma estructurada, escalable y alineada con las prácticas actuales de Flutter + Firebase (2024-2026).

---

## 🛠️ 1. Herramientas y Entorno de Desarrollo

| Categoría | Herramienta | Propósito |
|-----------|-------------|-----------|
| **IDE Principal** | Visual Studio Code | Desarrollo rápido, extensiones oficiales de Flutter/Dart |
| **IDE Nativo (opcional)** | Android Studio / Xcode | Emuladores, firma de apps, depuración nativa |
| **SDKs** | Flutter (canal estable) + Dart | Base del framework multiplataforma |
| **Control de Versiones** | Git + GitHub/GitLab | Historial, colaboración, CI/CD |
| **Firebase** | Firebase Console + Firebase CLI | Backend, autenticación, base de datos, despliegue |
| **Diseño UI/UX** | Figma / Penpot | Wireframes, prototipos, design system, handoff |
| **Gestión de Assets** | SVG Repo, Flaticon, Unsplash | Iconografía, ilustraciones, imágenes de prueba |
| **Pruebas** | Flutter DevTools, Postman/Insomnia (Firebase REST) | Depuración, monitoreo de rendimiento, validación de reglas |

---

## 🎨 2. Diseño UI/UX

### 🔹 Fases de Diseño
1. **Investigación y Referencias:** Analizar flujos de Amazon, MercadoLibre y apps de e-commerce modernas.
2. **Arquitectura de Información:** Mapa de pantallas (Onboarding → Login → Home → Catálogo → Detalle → Carrito → Checkout → Perfil).
3. **Wireframes de Baja Fidelidad:** Definir disposición de elementos sin distracciones visuales.
4. **Design System:**
   - Paleta de colores (primario, secundario, estados, neutros)
   - Tipografía (tamaños, pesos, jerarquía)
   - Espaciado y grids (8pt base system)
   - Componentes reutilizables: botones, cards, inputs, skeletons, snackbars
5. **Prototipo Interactivo:** Validar navegación, transiciones y retroalimentación visual.
6. **Handoff a Desarrollo:** Exportar assets, tokens de diseño, especificaciones de layout y accesibilidad.

### 🔹 Principios UX Aplicados
- **Ley de Fitts & Hick:** Minimizar clicks para acciones clave.
- **Feedback Inmediato:** Indicadores de carga, validaciones en tiempo real, estados vacíos.
- **Accesibilidad:** Contraste WCAG AA, soporte para screen readers, tamaños de fuente dinámicos.
- **Responsive/Adaptativo:** Layouts que funcionen en móvil, tablet y escritorio (Flutter adaptive).

---

## 🔥 3. Configuración de Firebase

1. Crear proyecto en Firebase Console.
2. Registrar aplicaciones: Android, iOS y Web.
3. Configurar archivos de configuración nativos (`google-services.json`, `GoogleService-Info.plist`).
4. Habilitar **Authentication** → Método: Email/Password.
   - Activar verificación por correo (opcional pero recomendado).
   - Configurar políticas de contraseña segura.
5. Crear base de datos **Firestore** en modo producción.
   - Definir colecciones principales: `users`, `products`, `categories`, `carts`, `orders`.
   - Establecer reglas de seguridad iniciales (lectura pública para catálogo, escritura/lectura privada para datos de usuario).
6. (Opcional) Configurar **Firebase Storage** para imágenes de productos y avatares.
7. Instalar Firebase CLI y ejecutar comando de configuración automática para Flutter (`flutterfire configure`).

---

## 🏗️ 4. Arquitectura y Gestión de Estado

- **Patrón recomendado:** MVVM simplificado o Clean Architecture ligera.
- **Capas:**
  - `UI`: Widgets, pantallas, componentes visuales.
  - `Logic`: Providers, gestión de estado, orquestación de flujos.
  - `Data`: Servicios de Firebase, modelos, mapeo DTO → Entity.
  - `Core`: Utilidades, constantes, temas, enrutamiento.
- **Gestión de Estado:** `provider` como estado global y local.
  - `AuthProvider`: Sesión, datos de usuario, estado de autenticación.
  - `CartProvider`: Artículos, totales, sincronización con Firestore.
  - `CatalogProvider`: Listado, filtros, paginación, caché local.
- **Navegación:** `go_router` o `Navigator 2.0` con protección de rutas (middleware de auth).
- **Manejo de Errores:** Clases de error tipadas, mensajes traducidos, fallback UI.

---

## 📦 5. Dependencias Clave (`pubspec.yaml`)

> ⚠️ Se listan los paquetes necesarios. Las versiones deben ser las **últimas estables compatibles con Flutter 3.x** al momento del desarrollo.

```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^latest
  firebase_auth: ^latest
  cloud_firestore: ^latest
  firebase_storage: ^latest  # si se usan imágenes externas
  provider: ^latest
  cached_network_image: ^latest
  fluttertoast: ^latest
  intl: ^latest
  go_router: ^latest  # o auto_route
  equatable: ^latest
  uuid: ^latest
  shared_preferences: ^latest  # para preferencias locales
  image_picker: ^latest  # si se permite subir fotos

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^latest
  build_runner: ^latest  # si se usa generación de código
  mocktail: ^latest
```

> ✅ **Recomendación:** Ejecutar `flutter pub deps` tras la instalación para validar compatibilidad y evitar conflictos de versiones.

---

## 📋 6. Procedimiento Paso a Paso (Fases de Desarrollo)

### 🟢 Fase 1: Configuración Inicial del Proyecto
- [ ] Crear proyecto Flutter con estructura de carpetas (`lib/`, `assets/`, `test/`).
- [ ] Configurar `pubspec.yaml` con las dependencias listadas.
- [ ] Configurar Firebase con CLI y generar archivos de configuración nativos.
- [ ] Establecer `.gitignore` correcto y primer commit estructural.
- [ ] Validar compilación en Android, iOS y Web.

### 🟢 Fase 2: Esqueleto UI y Navegación Base
- [ ] Implementar tema global (colores, tipografía, sombras, bordes).
- [ ] Crear estructura de navegación con protección de rutas (rutas públicas vs privadas).
- [ ] Desarrollar layout base: `Scaffold`, `AppBar`, `BottomNavigationBar`, `Drawer` (si aplica).
- [ ] Implementar placeholders y estados de carga/esqueleto.
- [ ] Validar responsive behavior en múltiples tamaños de pantalla.

### 🟢 Fase 3: Autenticación (Email/Password)
- [ ] Diseñar pantallas de Login y Registro con validaciones UX.
- [ ] Implementar `AuthProvider` con `provider` para manejar sesión.
- [ ] Conectar con Firebase Auth: creación de cuenta, inicio de sesión, cierre, recuperación de contraseña.
- [ ] Persistir sesión y manejar reconexión automática al reiniciar la app.
- [ ] Pruebas de flujo: credenciales inválidas, cuenta no verificada, errores de red.

### 🟢 Fase 4: Integración con Firestore y Modelos de Datos
- [ ] Definir clases de modelo para `User`, `Product`, `CartItem`, `Order`.
- [ ] Crear servicios de acceso a Firestore (`FirestoreService`).
- [ ] Implementar lectura de catálogo con paginación y filtros básicos.
- [ ] Sincronizar datos del usuario autenticado con la colección `users`.
- [ ] Configurar índices compuestos en Firestore para consultas optimizadas.

### 🟢 Fase 5: Carrito de Compras y Estado Global
- [ ] Implementar `CartProvider` con operaciones: agregar, eliminar, modificar cantidad, calcular total.
- [ ] Persistir carrito localmente (`shared_preferences`) y sincronizar con Firestore al autenticarse.
- [ ] Mostrar notificaciones visuales y actualización en tiempo real del badge del carrito.
- [ ] Validar stock y disponibilidad antes de confirmar adición.

### 🟢 Fase 6: Flujos Completos y Pulido UX
- [ ] Conectar pantallas: Catálogo → Detalle → Carrito → Checkout → Confirmación.
- [ ] Implementar búsqueda y filtros avanzados (categoría, precio, valoración).
- [ ] Añadir animaciones de transición, microinteracciones y feedback háptico/visual.
- [ ] Optimizar carga de imágenes (`cached_network_image`, placeholders, compresión).
- [ ] Revisar accesibilidad y usabilidad con pruebas manuales y grabación de sesiones.

### 🟢 Fase 7: Pruebas, Seguridad y Despliegue
- [ ] Ejecutar pruebas unitarias (servicios, modelos, providers).
- [ ] Ejecutar pruebas de widget (pantallas críticas, navegación, estados vacíos).
- [ ] Refinar reglas de seguridad de Firestore y Storage.
- [ ] Configurar variables de entorno y secretos (API keys, IDs de proyecto).
- [ ] Generar builds firmados: APK/AAB (Android), IPA (iOS), Web deploy.
- [ ] Subir a Firebase Hosting (Web), Play Console y App Store Connect.
- [ ] Configurar monitoreo: Crashlytics, Performance Monitoring, Analytics.

---

## ✅ 7. Recomendaciones Finales y Buenas Prácticas

| Área | Práctica |
|------|----------|
| **Versionado** | Commits semánticos, ramas `feature/`, `hotfix/`, `release/` |
| **Seguridad** | Nunca exponer keys en código, usar `.env` o configuración nativa segura |
| **Rendimiento** | Lazy loading, paginación Firestore, `const` en widgets estáticos, evitar rebuilds innecesarios |
| **Mantenibilidad** | Widgets extraídos en archivos, documentación inline, comentarios de contexto |
| **Escalabilidad** | Preparar arquitectura para futuras integraciones (Stripe, push notifications, offline mode) |
| **Calidad** | Linting estricto (`flutter analyze`), formateo automático (`flutter format`), CI/CD básico |

---

📌 **Próximo paso sugerido:** Una vez validado este plan, puedo generar:
- Estructura de carpetas detallada
- Flujos de estado para `provider` (diagramas o descripción textual)
- Reglas de seguridad de Firestore específicas para e-commerce
- Checklist de pruebas por fase

¿Deseas que profundice en alguna fase o que prepare el siguiente entregable sin código?
