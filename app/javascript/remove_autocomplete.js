document.addEventListener('DOMContentLoaded', () => {
    const hiddenInputs = document.querySelectorAll('input[type="hidden"][autocomplete="off"]');
    hiddenInputs.forEach(input => {
      input.removeAttribute('autocomplete');
    });
  });
  