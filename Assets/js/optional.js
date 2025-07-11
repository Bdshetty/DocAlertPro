document.addEventListener("DOMContentLoaded", () => {
    const homeSection = document.querySelector('.home');
    const parallaxElements = document.querySelectorAll('.home-parallax');

if (!homeSection || parallaxElements.length === 0) return;

let animationFrame;

    const handleMouseMove = (e) => {
        const centerX = window.innerWidth / 2;
        const centerY = window.innerHeight / 2;

cancelAnimationFrame(animationFrame);

animationFrame = requestAnimationFrame(() => {
    parallaxElements.forEach(element => {
        const speed = parseFloat(element.getAttribute('data-speed')) || 1;

                const offsetX = (e.pageX - centerX) * speed / 100;
                const offsetY = (e.pageY - centerY) * speed / 100;

element.style.transform = `translate(${offsetX}px, ${offsetY}px)`;
});
});
};

    const handleMouseLeave = () => {
        parallaxElements.forEach(element => {
            element.style.transition = 'transform 0.5s ease';
element.style.transform = 'translate(0px, 0px)';
});

setTimeout(() => {
    parallaxElements.forEach(element => {
        element.style.transition = '';
});
}, 500);
};

homeSection.addEventListener('mousemove', handleMouseMove);
homeSection.addEventListener('mouseleave', handleMouseLeave);
});
