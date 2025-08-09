# Keep Droning – statyczna strona www

Nowoczesna, responsywna strona wizytówka dla firmy „Keep Droning” (HTML5 + Tailwind CSS + JavaScript). Gotowa do wdrożenia na GitHub Pages.

## Funkcje
- Sekcje: Strona główna (hero), O firmie, Usługi, Portfolio (filtrowanie), Kontakt (formularz, mapa, social), FAQ, Stopka
- SEO: meta tagi, Open Graph/Twitter, JSON-LD, sitemap.xml, robots.txt, canonical
- Wydajność: lazy-loading obrazów, lekki JS, brak frameworka
- UX: nawigacja mobilna, gładkie przewijanie, CTA

## Struktura
```
index.html
assets/
  css/custom.css
  js/main.js
robots.txt
sitemap.xml
.nojekyll
```

## Lokalny podgląd
Możesz użyć dowolnego serwera statycznego, np. w Pythonie:
```bash
python3 -m http.server 8080
# potem otwórz: http://localhost:8080
```

## Wdrożenie na GitHub Pages
1. Utwórz repozytorium na GitHub, np. `keep-droning`.
2. Dodaj pliki i wypchnij repo:
```bash
git init
git add .
git commit -m "Init: Keep Droning site"
git branch -M main
git remote add origin git@github.com:<twoj-username>/keep-droning.git
git push -u origin main
```
3. Włącz Pages: Settings → Pages → Source: `Deploy from a branch` → Branch: `main` → `/ (root)` → Save.
4. Po kilku minutach strona będzie pod `https://<twoj-username>.github.io/keep-droning/`.
5. (Opcjonalnie) Konfiguruj własną domenę w sekcji Pages (CNAME, DNS).

## Co zaktualizować pod własny projekt
- W `index.html` uzupełnij dane kontaktowe, NIP, linki do social, logo.
- Zastąp `yourusername` w `index.html`, `robots.txt` i `sitemap.xml` swoją nazwą użytkownika oraz popraw `canonical`.
- Podmień obrazy na własne, zoptymalizowane (WebP/AVIF). Ustaw `width`/`height` i `loading="lazy"`.
- Jeśli chcesz prawdziwy formularz (bez mailto), dodaj np. Formspree lub własne API:
  - Zmień handler w `assets/js/main.js` lub ustaw `action="https://formspree.io/f/<id>" method="POST"` i usuń obsługę mailto w JS.

## Paleta i fonty
- Kolory: granat `#0b1b34`, akcent pomarańcz `#ff7a1a`, tło białe
- Font: Inter (Google Fonts)

## Licencja
Projekt udostępniony w celach demonstracyjnych. Przed publikacją uzupełnij dane firmy i materiały.