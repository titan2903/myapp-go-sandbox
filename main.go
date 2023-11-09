package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

func (Customers) TableName() string {
	return "Customers"
}

type Customers struct {
	ID      int16  `gorm:"column:ID"`
	Name    string `gorm:"column:Name"`
	Address string `gorm:"column:Address"`
}

func main() {
	r := gin.Default()

	var users []Customers

	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"code":     200,
			"language": "go version go1.20.6",
			"message":  "Server running on port 8000",
			"version":  "v5.0",
		})
	})
	r.GET("/env", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"code":     200,
			"data_env": os.Environ(),
		})
	})

	r.GET("/customers", func(c *gin.Context) {
		dsn := fmt.Sprintf("%v:%v@tcp(%v)/%v", os.Getenv("DB_USER"), os.Getenv("DB_PASSWORD"), os.Getenv("DB_HOST"), os.Getenv("DB_NAME"))
		db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})

		msg := "connected to database"
		if err != nil {
			msg = err.Error()
		}

		db.Find(&users)

		c.JSON(http.StatusOK, gin.H{
			"code":     200,
			"language": "go version go1.20.6",
			"message":  msg,
			"data":     users,
			"version":  "v2.0",
		})
	})

	r.Run(":8060")
}
