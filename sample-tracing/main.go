package main

import (
	"math/rand"
	"net/http"
	"time"

	"github.com/opentracing/opentracing-go"
	"github.com/uber/jaeger-client-go"
	"github.com/uber/jaeger-client-go/config"
)

func main() {
	cfg := config.Configuration{
		Sampler: &config.SamplerConfig{
			Type:  "const",
			Param: 1,
		},
		Reporter: &config.ReporterConfig{
			LogSpans:            true,
			BufferFlushInterval: 1 * time.Second,
		},
	}

	tracer, closer, err := cfg.New("nowapp-api", config.Logger(jaeger.StdLogger))
	if err != nil {
		panic(err)
	}
	defer closer.Close()

	opentracing.SetGlobalTracer(tracer)

	http.HandleFunc("/", handle)
	http.ListenAndServe(":8080", nil)
}

func handle(w http.ResponseWriter, r *http.Request) {
	parent := opentracing.GlobalTracer().StartSpan("handler")
	defer parent.Finish()

	cacheSpan := opentracing.GlobalTracer().StartSpan("cache", opentracing.ChildOf(parent.Context()))
	d := rand.Intn(100)
	time.Sleep(time.Duration(d) * time.Millisecond)
	cacheSpan.Finish()

	promotionSpan := opentracing.GlobalTracer().StartSpan("promotion", opentracing.ChildOf(parent.Context()))
	d = rand.Intn(100)
	time.Sleep(time.Duration(d) * time.Millisecond)
	promotionSpan.Finish()

	dbSpan := opentracing.GlobalTracer().StartSpan("db", opentracing.ChildOf(parent.Context()))
	d = rand.Intn(100)
	time.Sleep(time.Duration(d) * time.Millisecond)
	dbSpan.Finish()

	w.Write([]byte("Hello world!!!"))
	w.WriteHeader(http.StatusOK)
}

