
function username(e) {
    var nums = "abcdefghijklmnñopqrstuvwxyz0123456789-_";
    var x = e.which || e.keyCode;
    var num = String.fromCharCode(x);
    var n = nums.indexOf(num);
    if (n === -1)
        return false;
    else
        return true;
}
function password(e) {
    var nums = "abcdefghijklmnñopqrstuvwxyz0123456789-_.";
    var x = e.which || e.keyCode;
    var num = String.fromCharCode(x);
    var n = nums.indexOf(num);
    if (n === -1)
        return false;
    else
        return true;
}

function validaContra() {
    var contra = document.getElementById("TxtPass").value;
    var confirma = document.getElementById("contra2").value;
    var longitud = contra.length;

    if (longitud < 6)
        alert("La contraseña debe contener mínimo 6 caracteres");
    else
    if (contra !== confirma)
        alert("Las contraseñas no coinciden");
    else
        return true;
}

function validaVacio() {
    var nombre = document.getElementById("TxtNombre").value;
    var mail = document.getElementById("TxtCorreo").value;
    var pswd = document.getElementById("TxtPass").value;
    var tipo = document.getElementById("SelectUsu").value;

    if (nombre === "" && mail === "" && pswd === "" && tipo === "") {
        alert("No dejes los campos vacios");
        return false;
    }
}
function valida() {
    // Ninguno campo vacìo
    if (!validaVacio())
        return false;
    // Contraseña coinicide

    document.prof.submit();
}
