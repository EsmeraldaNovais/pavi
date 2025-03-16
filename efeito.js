const navmenu = document.querySelector(".navmenu");
const nav = document.querySelector(".nav");

navmenu.addEventListener("click", () => nav.classList.toggle("active"));

let slideIndex = 0;

function showSlides(n) {
    const slides = document.getElementsByClassName("card");
    const totalSlides = slides.length;
    
    // Ajusta o índice de exibição
    if (n >= totalSlides / 3) {
        slideIndex = 0;
    } 
    if (n < 0) {
        slideIndex = Math.floor(totalSlides / 3) - 1;
    }
    
    // Atualiza a posição do carrossel
    const offset = slideIndex * -33.33; // Mover o carrossel
    document.querySelector(".slides").style.transform = `translateX(${offset}%)`;

    // Exibir os cards
    for (let i = 0; i < totalSlides; i++) {
        slides[i].style.display = "block";  
    }
}

function plusSlides(n) {
    showSlides(slideIndex += n);
}

// Inicializa o carrossel
showSlides(slideIndex);
