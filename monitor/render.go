package main

import (
	"embed"
	"html/template"
	"log"
	"net/http"
	"sort"
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
}

//go:embed frontpage.html
var templateFS embed.FS
var frontPageTemplate = template.Must(template.ParseFS(templateFS, "frontpage.html"))

func (m *MimuxServer) renderFrontPage(w http.ResponseWriter) {
	data := FrontPageData{
		Packages: make([]FrontPagePackage, 0, 30),
		Updated:  m.getUpdated(),
	}
	keys := make([]string, len(m.packages))
	idx := 0
	for key := range m.packages {
		keys[idx] = key
		idx++
	}
	sort.Strings(keys)

	for _, key := range keys {
		current := m.packages[key].Current
		latest := m.packages[key].Latest
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
