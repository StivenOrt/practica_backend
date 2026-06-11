# --- Etapa 1: Build ---
FROM node:20-alpine AS builder

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

# --- Etapa 2: Runner (producción) ---
FROM node:20-alpine AS runner

WORKDIR /app

# Corrección 2: entorno de producción
ENV NODE_ENV=production

COPY package.json package-lock.json ./
# Corrección 3: solo dependencias de producción
RUN npm ci --omit=dev

# Corrección 4: copiar el build desde la etapa anterior
COPY --from=builder /app/dist ./dist

# Corrección 6: EXPOSE antes del CMD, puerto correcto
EXPOSE 8080

# Corrección 5: punto de entrada correcto
CMD ["node", "dist/main.js"]