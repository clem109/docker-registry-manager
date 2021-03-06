package main

import (
	"math"
	"strconv"
	"strings"
	"time"

	"code.cloudfoundry.org/bytefmt"
)

func DigestShortener(s string) string {
	shortener := strings.SplitAfter(s, "sha256:")
	return string(shortener[1][0:8])
}

func ByteDiffFmt(val1 int64, val2 int64) string {
	if val1 > val2 {
		return ByteFmt(val2 - val1)
	}
	return ByteFmt(val2 - val1)
}

func ByteFmt(v interface{}) string {
	switch u := v.(type) {
	case string:
		val, _ := strconv.Atoi(u)
		return bytefmt.ByteSize(uint64(val))
	case int:
		return bytefmt.ByteSize(uint64(u))
	case int8:
		return bytefmt.ByteSize(uint64(u))
	case int16:
		return bytefmt.ByteSize(uint64(u))
	case int32:
		return bytefmt.ByteSize(uint64(u))
	case int64:
		return bytefmt.ByteSize(uint64(u))
	case uint:
		return bytefmt.ByteSize(uint64(u))
	case uint8:
		return bytefmt.ByteSize(uint64(u))
	case uint16:
		return bytefmt.ByteSize(uint64(u))
	case uint32:
		return bytefmt.ByteSize(uint64(u))
	case uint64:
		return bytefmt.ByteSize(u)
	default:
		return ""
	}
}

// TimeAgo returns the rounded form of amount of time elapsed between now and the passed time
func TimeAgo(passedTime time.Time) string {

	// Get the elapsed number of hours
	floatHoursAgo := time.Since(passedTime).Seconds()

	// Take abs value since we handle the "ago" part below
	floatHoursAgo = math.Abs(floatHoursAgo)

	// Round the float
	secondsAgo := Round(floatHoursAgo)

	switch {
	case secondsAgo < 60:
		return strconv.Itoa(secondsAgo) + " seconds ago"
	case secondsAgo >= 60 && secondsAgo < 3600:
		return strconv.Itoa(secondsAgo/60) + " minutes ago"
	case secondsAgo >= 3600 && secondsAgo < 86400:
		if secondsAgo/3600 == 1 {
			return "1 hour ago"
		}
		return strconv.Itoa(secondsAgo/3600) + " hours ago"
	case secondsAgo >= 86400:
		if secondsAgo/86400 == 1 {
			return "1 day ago"
		}
		return strconv.Itoa(secondsAgo/86400) + " days ago"
	}

	return ""
}

// Round rounds the float to the nearest int
func Round(f float64) int {
	if math.Abs(f) < 0.5 {
		return 0
	}
	return int(f + math.Copysign(0.5, f))
}

// StatToSeconds takes in a beego stat param (e.g 20.40us or 15.20ms) and returns the time in seconds
func StatToSeconds(stat string) (float64, error) {
	t, err := time.ParseDuration(stat)
	if err != nil {
		return 0, err
	}
	return t.Seconds(), nil
}
