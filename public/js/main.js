// KidzView Website JavaScript

document.addEventListener('DOMContentLoaded', () => {
    initNavbar();
    initSmoothScroll();
    initMobileMenu();
    initAnimations();
    initTestimonialSlider();
});

// ========================================
// Navbar Scroll Effect
// ========================================

function initNavbar() {
    const navbar = document.querySelector('.navbar');
    
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });
    
    // Active nav link on scroll
    const sections = document.querySelectorAll('section[id]');
    const navLinks = document.querySelectorAll('.nav-link');
    
    window.addEventListener('scroll', () => {
        let current = '';
        
        sections.forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.clientHeight;
            
            if (window.scrollY >= sectionTop - 100) {
                current = section.getAttribute('id');
            }
        });
        
        navLinks.forEach(link => {
            link.classList.remove('active');
            if (link.getAttribute('href') === `#${current}`) {
                link.classList.add('active');
            }
        });
    });
}

// ========================================
// Smooth Scroll
// ========================================

function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const href = this.getAttribute('href');
            
            // Skip if href is just "#"
            if (href === '#') {
                e.preventDefault();
                return;
            }
            
            const target = document.querySelector(href);
            
            if (target) {
                e.preventDefault();
                
                const navbarHeight = document.querySelector('.navbar').offsetHeight;
                const targetPosition = target.offsetTop - navbarHeight;
                
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
                
                // Close mobile menu if open
                const navMenu = document.querySelector('.nav-menu');
                if (navMenu) {
                    navMenu.classList.remove('active');
                }
            }
        });
    });
}

// ========================================
// Mobile Menu Toggle
// ========================================

function initMobileMenu() {
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
    const navMenu = document.querySelector('.nav-menu');
    
    if (mobileMenuToggle && navMenu) {
        mobileMenuToggle.addEventListener('click', () => {
            navMenu.classList.toggle('active');
            mobileMenuToggle.classList.toggle('active');
            
            // Prevent body scroll when menu is open
            document.body.style.overflow = navMenu.classList.contains('active') ? 'hidden' : '';
        });
        
        // Close menu when clicking outside
        document.addEventListener('click', (e) => {
            if (!navMenu.contains(e.target) && !mobileMenuToggle.contains(e.target)) {
                navMenu.classList.remove('active');
                mobileMenuToggle.classList.remove('active');
                document.body.style.overflow = '';
            }
        });
    }
}

// ========================================
// Scroll Animations
// ========================================

function initAnimations() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animation = 'fadeIn 0.6s ease forwards';
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);
    
    // Observe feature cards
    document.querySelectorAll('.feature-card, .solution-card, .showcase-card, .gallery-card, .price-card').forEach(card => {
        observer.observe(card);
    });
}

// ========================================
// Testimonial Slider
// ========================================

function initTestimonialSlider() {
    const cards = Array.from(document.querySelectorAll('.testimonial-card'));
    const dots = Array.from(document.querySelectorAll('.slider-dots .dot'));
    if (!cards.length || !dots.length) return;
    
    let current = 0;
    let intervalId;
    
    const setActive = (index) => {
        cards.forEach((card, i) => {
            card.classList.toggle('active', i === index);
        });
        dots.forEach((dot, i) => {
            dot.classList.toggle('active', i === index);
        });
        current = index;
    };
    
    const next = () => setActive((current + 1) % cards.length);
    
    const start = () => {
        clearInterval(intervalId);
        intervalId = setInterval(next, 4500);
    };
    
    dots.forEach((dot, i) => {
        dot.addEventListener('click', () => {
            setActive(i);
            start();
        });
    });
    
    start();
}

// ========================================
// Form Handling (for future contact forms)
// ========================================

function initForms() {
    const forms = document.querySelectorAll('form');
    
    forms.forEach(form => {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const formData = new FormData(form);
            const data = Object.fromEntries(formData);
            
            // Add your form submission logic here
            console.log('Form submitted:', data);
            
            // Show success message
            alert('Thank you for your interest! We will contact you soon.');
            form.reset();
        });
    });
}

// ========================================
// Utility Functions
// ========================================

function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Performance optimization for scroll events
const optimizedScroll = debounce(() => {
    // Add any scroll-based logic here
}, 100);

window.addEventListener('scroll', optimizedScroll);

