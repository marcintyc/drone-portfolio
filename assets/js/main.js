// Mobile menu toggle
const menuToggleButton = document.getElementById('menuToggle');
const mobileMenu = document.getElementById('mobileMenu');
if (menuToggleButton && mobileMenu) {
  menuToggleButton.addEventListener('click', () => {
    mobileMenu.classList.toggle('hidden');
  });
}

// Smooth scrolling for anchor links
const anchorLinks = document.querySelectorAll('a[href^="#"]');
anchorLinks.forEach((link) => {
  link.addEventListener('click', (e) => {
    const href = link.getAttribute('href');
    if (!href || href === '#' || href.length === 1) return;
    const target = document.querySelector(href);
    if (target) {
      e.preventDefault();
      const headerOffset = 72; // approx height of fixed header
      const elementPosition = target.getBoundingClientRect().top + window.pageYOffset;
      const offsetPosition = elementPosition - headerOffset;
      window.scrollTo({ top: offsetPosition, behavior: 'smooth' });
      if (mobileMenu && !mobileMenu.classList.contains('hidden')) {
        mobileMenu.classList.add('hidden');
      }
    }
  });
});

// Portfolio filtering
const filterButtons = document.querySelectorAll('.filter-btn');
const portfolioItems = document.querySelectorAll('.portfolio-item');
filterButtons.forEach((btn) => {
  btn.addEventListener('click', () => {
    const filter = btn.getAttribute('data-filter');
    filterButtons.forEach((b) => b.classList.remove('active', 'bg-accent', 'text-white'));
    btn.classList.add('active', 'bg-accent', 'text-white');

    portfolioItems.forEach((item) => {
      const cat = item.getAttribute('data-category');
      if (filter === 'all' || filter === cat) {
        item.classList.remove('hidden');
      } else {
        item.classList.add('hidden');
      }
    });
  });
});

// Contact form -> mailto composer (no backend)
const contactForm = document.getElementById('contactForm');
if (contactForm) {
  contactForm.addEventListener('submit', (e) => {
    e.preventDefault();

    const formData = new FormData(contactForm);
    // Honeypot
    if ((formData.get('_hp') || '').toString().trim().length > 0) {
      return; // bot
    }

    const name = (formData.get('imie') || '').toString().trim();
    const email = (formData.get('email') || '').toString().trim();
    const phone = (formData.get('telefon') || '').toString().trim();
    const subjectInput = (formData.get('temat') || '').toString().trim();
    const message = (formData.get('wiadomosc') || '').toString().trim();

    const subject = subjectInput || `Zapytanie – Keep Droning – ${name || 'bez nazwy'}`;

    const bodyLines = [
      'Dzień dobry,',
      '',
      message,
      '',
      `Imię i nazwisko: ${name}`,
      `E-mail: ${email}`,
      phone ? `Telefon: ${phone}` : '',
      '',
      '---',
      'Wiadomość wysłana z formularza keep-droning'
    ].filter(Boolean);

    const mailto = `mailto:kontakt@keepdroning.pl?subject=${encodeURIComponent(subject)}&body=${encodeURIComponent(bodyLines.join('\n'))}`;
    window.location.href = mailto;

    // Optional: show a friendly toast
    alert('Otwieramy klienta poczty z przygotowaną wiadomością. Dziękujemy!');
    contactForm.reset();
  });
}