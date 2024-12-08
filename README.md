# 🌐 NetScan

Una poderosa herramienta de escaneo de red escrita en Bash que proporciona múltiples métodos para descubrir dispositivos en tu red local.

## ✨ Características

- **📡 Múltiples Métodos de Escaneo**:
  - Escaneo ARP: Utiliza `arp-scan` para descubrir dispositivos mediante peticiones ARP
  - Escaneo Ping: Emplea `fping` para la detección de hosts mediante ICMP
- **🔍 Selección de Interfaz**: Detecta automáticamente y permite elegir las interfaces de red disponibles
- **👥 Amigable**: Salida con colores para mejor legibilidad y mensajes de estado claros
- **⚡ Eficiente**: Optimizado para un descubrimiento rápido de red con uso mínimo de recursos

## 📋 Requisitos Previos

La herramienta requiere tener instalados los siguientes paquetes:
- `arp-scan`
- `fping`

El script ofrecerá instalar estas dependencias automáticamente si faltan (requiere privilegios de root).

## 🛠️ Instalación

1. Clona este repositorio:
```bash
git clone https://github.com/tuusuario/netscan.git
cd netscan
```

2. Haz el script ejecutable:
```bash
chmod +x netscan.sh
```

## 📖 Uso

```bash
./netscan.sh -s [modo-escaneo]
```

### Opciones Disponibles:
- `-s`: Selecciona el modo de escaneo
  - `arpScan`: Realiza un escaneo utilizando ARP
  - `pingScan`: Realiza un escaneo utilizando ping
- `-h`: Muestra el panel de ayuda

## 🎯 Ejemplos de Uso

1. Realizar un escaneo ARP:
```bash
./netscan.sh -s arpScan
```

2. Realizar un escaneo Ping:
```bash
./netscan.sh -s pingScan
```

## 🔒 Seguridad

Esta herramienta está diseñada para ser utilizada en redes donde tengas autorización para realizar escaneos. No la utilices en redes sin el permiso correspondiente.

## 👨‍💻 Autor

**Jorge Arana Fedriani**

## 💡 Agradecimientos

- A la comunidad de código abierto por las herramientas utilizadas
- A todos los contribuidores que ayudan a mejorar este proyecto

---
⭐ Si este proyecto te ha sido útil, considera darle una estrella en GitHub!
