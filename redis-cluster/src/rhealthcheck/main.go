package main

import (
	"context"
	"fmt"
	"net/http"
	"strings"
	"time"

	"github.com/go-redis/redis/v8"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		upstream := r.Header.Get("X-Upstream-Addr")
		if strings.TrimSpace(upstream) == "" {
			fmt.Println("No upstream")
			w.WriteHeader(http.StatusServiceUnavailable)
			fmt.Fprintf(w, "Unavailable upstream\n")
			return
		}

		client := redis.NewClient(&redis.Options{
			Addr:         upstream,
			DialTimeout:  time.Second,
			ReadTimeout:  300 * time.Millisecond,
			WriteTimeout: 300 * time.Millisecond,
		})

		result, err := client.Info(context.TODO(), "replication").Result()
		if err != nil {
			fmt.Println("Unable to query info")
			w.WriteHeader(http.StatusServiceUnavailable)
			fmt.Fprintf(w, "Unavailable upstream\n")
			return
		}

		if !strings.Contains(result, "role:master") {
			fmt.Printf("%s not master\n", upstream)
			w.WriteHeader(http.StatusServiceUnavailable)
			fmt.Fprintf(w, "Not master\n")
			return
		}

		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "OK\n")
	})

	http.ListenAndServe(":9999", nil)
}
