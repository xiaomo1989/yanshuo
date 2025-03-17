# 多阶段构建示例：使用国内源加速构建

# 第一阶段：Golang构建（使用阿里云镜像源）
FROM registry.cn-hangzhou.aliyuncs.com/google_containers/golang:1.21-alpine AS builder

# 配置 Alpine 国内源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装构建依赖
RUN apk add --no-cache  gcc   musl-dev   git

WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 go build -o main .

# 第二阶段：生产镜像（使用腾讯云 Alpine 镜像）
FROM registry.cn-hangzhou.aliyuncs.com/google_containers/alpine:3.18

# 配置 Alpine 国内源
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# 安装运行时依赖（使用国内源加速）
RUN apk add --no-cache  ca-certificates   tzdata   curl

# 设置时区为上海
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

COPY --from=builder /app/main /app/main
EXPOSE 8080
CMD ["/app/main"]
