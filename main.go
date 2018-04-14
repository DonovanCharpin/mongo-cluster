package main

import (
	"fmt"
	"time"

	mgo "gopkg.in/mgo.v2"
)

const url = "mongodb://mongo0:27017/?replicaSet=rs0"

func main() {
	session, err := mgo.Dial(url)
	if err != nil {
		panic(err)
	}

	db := session.DB("test")
	c := db.C("users")

	t := time.NewTicker(time.Second)
	for _ = range t.C {
		count, err := c.Count()
		if err != nil {
			panic(err)
		}

		fmt.Println(time.Now(), count)
	}
}
