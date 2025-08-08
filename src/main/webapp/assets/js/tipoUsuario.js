document.addEventListener('DOMContentLoaded', function () {
    const tipoSelect = document.getElementById('tipoUsuario');
    const navLocador = document.querySelectorAll('.nav-locador');
    const navLocatario = document.querySelectorAll('.nav-locatario');

    function atualizarVisibilidade(tipo) {
        if (tipo === 'locador') {
            navLocador.forEach(element => element.style.display = 'inline');
            navLocatario.forEach(element => element.style.display = 'none');
        } else {
            navLocador.forEach(element => element.style.display = 'none');
            navLocatario.forEach(element => element.style.display = 'inline');
        }
    }

    const tipoSalvo = localStorage.getItem('tipoUsuario') || 'locador';
    tipoSelect.value = tipoSalvo;
    atualizarVisibilidade(tipoSalvo);

    tipoSelect.addEventListener('change', function () {
        const novoTipo = tipoSelect.value;
        localStorage.setItem('tipoUsuario', novoTipo);
        atualizarVisibilidade(novoTipo);
    });
});
