
FROM node:alpine AS prd
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 pnpm-lock.yaml 文件
COPY package.json pnpm-lock.yaml* ./

# 安装依赖（如果使用 pnpm）
RUN npm install -g pnpm

# 安装项目依赖
RUN pnpm install

# 复制项目文件
COPY . .

# 构建项目
RUN pnpm build

# 启动服务，提供 dist 目录下的静态文件
CMD ["pnpm", "preview", "--host", "0.0.0.0", "--port", "8000"]
