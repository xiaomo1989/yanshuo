package main

import (
	"github.com/gin-gonic/gin"
)

func main() {
	//穿件一个默认的路由引擎
	r := gin.Default()
	//http.ListenAndServe(":8089", r)

	//配置路由
	r.GET("/", func(c *gin.Context) {
		c.String(200, "值是%v", "你好我是gin")
	})

	r.GET("/ping", func(c *gin.Context) {
		c.JSON(200, gin.H{
			"message": "pong",
		})
	})

	//启动一个web服务
	r.Run() // 监听并在 0.0.0.0:8080 默认监听8080端口，如果要监听别的端口：r.Run(":8888")
}
