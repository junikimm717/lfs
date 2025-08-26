package main

import (
	"embed"
	"html/template"
	"log"
	"net/http"
	"sort"
	"time"
)

type FrontPagePackage struct {
	Name    string
	Current string
	Latest  string
	Updated bool
}

type FrontPageData struct {
	Updated  UpdatedInfo
	Packages []FrontPagePackage
	LastUpdated string
}

//go:embed frontpage.html
var templateFS embed.FS
var frontPageTemplate = template.Must(template.ParseFS(templateFS, "frontpage.html"))

func formatTime(millis int64) string {
	sec := millis / 1000
	ns := (millis % 1000) * int64(time.Millisecond)
	return time.Unix(sec, ns).UTC().Format("Mon Jan 2 2006 15:04:05 MST")
}

func (m *MimuxServer) renderFrontPage(w http.ResponseWriter) {
	data := FrontPageData{
		Packages: make([]FrontPagePackage, 0, 30),
		Updated:  m.getUpdated(),
		LastUpdated: formatTime(m.Data.LastUpdated),
	}
	keys := make([]string, len(m.Data.Packages))
	idx := 0
	for key := range m.Data.Packages {
		keys[idx] = key
		idx++
	}
	sort.Strings(keys)

	for _, key := range keys {
		current := m.Data.Packages[key].Current
		latest := m.Data.Packages[key].Latest
		data.Packages = append(data.Packages, FrontPagePackage{
			Name:    key,
			Current: current,
			Latest:  latest,
			Updated: current == latest,
		})
	}
	err := frontPageTemplate.Execute(w, data)
	if err != nil {
		log.Println(err)
	}
}
