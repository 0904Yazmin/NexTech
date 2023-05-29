<%@page import="java.sql.ResultSet"%>
<%@page import="Conexion.BD"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    HttpSession miSessiondelUsuario = (HttpSession) request.getSession();

    int idPersona = (int) (miSessiondelUsuario.getAttribute("id_usu") == null ? 0 : miSessiondelUsuario.getAttribute("id_usu"));
    if (idPersona < 1) {
        response.sendRedirect("../jsp/Menu.jsp");
    }
    String nombre = "";
    String correo = "";
    String foto = "";
    String tipo = "";
    String grado = "";
    BD basesita = new BD();
    basesita.conectar(); // no conectamos a la base de datos nexTech

    // (apartir de su id) Mandamos la instruccion (guardada en la variable UsuarioInfo) donde le decimos que vamos a seleccionar todos los datos del usuario que estan en la tabla Usuario 
    String UsuarioInfo = "Select * from Usuario where id_usu= '" + idPersona + "'";
    // Aparitr de un ResulSet consulta los datos 
    ResultSet rsDatosPer = basesita.consulta(UsuarioInfo);

    // (apartir de la id del usuario) Mandamos la instruccion (guardada en la variable datitos) donde decimos que vamos a seleccionar todos los datos que estan en la tabla Usuario_Clase, esto para obtener el id de la clase
    String datitos = "Select * from Usuario_Clase where id_usu = '" + idPersona + "'";
    //ResultSet Datos = basesita.consulta(datitos);
    ResultSet Dato_idClase = basesita.consulta(datitos);

    if (Dato_idClase.next()) {
        int id_class = Dato_idClase.getInt(2);

        // obtenemos la id de la clase (de la tabla Usuario_Clase) para relacionarla con la tabla Clases
        // (apartir de la id de clase) Mandamos la instruccion donde decimos que vamos a seleccionar todos los datos de la clase 
        String info_clase = "Select * from Clases where id_clase = '" + id_class + "'"; // seleccionamos los datos de la tabla Clases
        ResultSet ClaseInfo = basesita.consulta(info_clase);

        /*
    if (rsDatosPer.next()) {
        nombre = rsDatosPer.getString(2);
        correo = rsDatosPer.getString(3);
        foto = rsDatosPer.getString(5);
        tipo = rsDatosPer.getString(6);
        grado = rsDatosPer.getString(7);
    } */
        try {
            // (apartir de la id de clase) Mandamos la instruccion (guardada en la variable Post_Info) donde le decimos que vamos a seleccionar todos los datos del post que estan en la tabla Post
            String Post_Info = "Select * from Post where id_foro = '" + id_class + " ' order by id_post DESC "; // NOTA: el id_foro es igual al id_class pues al crear una clase tambien se crea su foro
            ResultSet post = basesita.consulta(Post_Info);


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Posts</title>
        <link rel="stylesheet" href="../../CSS/estilitos/reset.css"> <!-- CSS reset -->
        <link rel="stylesheet" href="../../CSS/CSS_foro/styleAddPost.css"> <!-- Resource style -->
        <script src="../../js/modernizr.js"></script> <!-- Modernizr -->
        <link href="../../CSS/CSS_foro/menu_D.css" rel="stylesheet" type="text/css"/>
        <link href="../../CSS/CSS_foro/foro.css" rel="stylesheet" type="text/css"/>
        <link href="../../CSS/barra_foro_doc.css" rel="stylesheet" type="text/css"/>
        <link href="../../CSS/CSS_foro/hero_foroA.css" rel="stylesheet" type="text/css"/>
        <link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css' rel='stylesheet'>
        <link rel="shorcut icon" href="../../General/img/logos/Newlogo.png">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');

            /* -------------------------------- 
            
            Buttons 
            
            -------------------------------- */
            .icon{  /**icon edit **/
                min-width:70px;
                height: 100%;
                display: flex;

                font-size: 29px;
            }
            .cd-btn {
                position: relative;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                white-space: nowrap;
                text-decoration: none;
                padding: 0.5rem 1rem;
                border-radius: 0.375em;
                font-size: 1em;
                text-decoration: none;
                line-height: 1.2;
                cursor: pointer;
                transition: 0.2s;
                will-change: transform;
            }

            .cd-btn:focus-visible {
                outline: none;
            }

            .cd-btn:active {
                transform: translateY(2px);
            }

            .cd-btn--primary {
                background: hsl(250, 84%, 54%);
                box-shadow: inset 0 1px 0 hsla(0, 0%, 100%, 0.15), 
                    0 1px 3px hsla(250, 84%, 38%, 0.25), 
                    0 2px 6px hsla(250, 84%, 38%, 0.1), 
                    0 6px 10px -2px hsla(250, 84%, 38%, 0.25);
                color: hsl(0, 0%, 100%);
            }

            .cd-btn--primary:hover {
                background: hsl(250, 84%, 60%);
                box-shadow: inset 0 1px 0 hsla(0, 0%, 100%, 0.15), 
                    0 1px 2px hsla(250, 84%, 38%, 0.25), 
                    0 1px 4px hsla(250, 84%, 38%, 0.1), 
                    0 3px 6px -2px hsla(250, 84%, 38%, 0.25);
            }

            .cd-btn--primary:focus-visible {
                box-shadow: inset 0 1px 0 hsla(0, 0%, 100%, 0.15), 
                    0 1px 2px hsla(250, 84%, 38%, 0.25), 
                    0 1px 4px hsla(250, 84%, 38%, 0.1), 
                    0 3px 6px -2px hsla(250, 84%, 38%, 0.25), 
                    0 0 0 2px hsl(0, 0%, 100%), 
                    0 0 0 4px hsl(250, 84%, 54%);
            }

            .cd-btn--subtle {
                background: hsl(0, 0%, 100%);
                color: hsl(230, 13%, 9%);
                box-shadow: inset 0 1px 0 hsla(0, 0%, 100%, 0.1), 
                    0 0 0 1px hsla(230, 13%, 9%, 0.02), 
                    0 0.3px 0.4px hsla(230, 13%, 9%, 0.025),
                    0 1px 3px -1px hsla(230, 13%, 9%, 0.2), 
                    0 3.5px 6px hsla(230, 13%, 9%, 0.12);
            }

            .cd-btn--subtle:hover {
                background: hsl(0, 0%, 100%);
                box-shadow: inset 0 1px 0 hsla(0, 0%, 100%, 0.1), 
                    0 0 0 1px hsla(230, 13%, 9%, 0.02), 
                    0 0.1px 0.3px hsla(230, 13%, 9%, 0.06),
                    0 1px 2px hsla(230, 13%, 9%, 0.12),
                    0 1px 3px -1px hsla(230, 13%, 9%, 0.2);
            }

            .cd-btn--subtle:focus-visible {
                box-shadow: inset 0 1px 0 hsla(0, 0%, 100%, 0.1), 
                    0 0 0 1px hsla(230, 13%, 9%, 0.02), 
                    0 0.3px 0.4px hsla(230, 13%, 9%, 0.025),
                    0 1px 3px -1px hsla(230, 13%, 9%, 0.2), 
                    0 3.5px 6px hsla(230, 13%, 9%, 0.12), 
                    0 0 0 2px hsl(0, 0%, 100%), 
                    0 0 0 4px hsl(230, 7%, 23%);
            }

            /* -------------------------------- 
            
            Icons 
            
            -------------------------------- */

            .cd-icon {
                --size: 1em;
                font-size: var(--size);
                height: 1em;
                width: 1em;
                display: inline-block;
                color: inherit;
                fill: currentColor;
                line-height: 1;
                flex-shrink: 0;
                max-width: initial;
            }

            .cd-icon use { /* SVG symbols - enable icon color corrections */
                color: inherit;
                fill: currentColor;
            }

            /* -------------------------------- 
            
            Component 
            
            -------------------------------- */

            .alert-card {
                position: relative;
                width: 60%;
                height: 40%;
                margin-left: auto; margin-right: auto;
                margin-bottom:2%;
                z-index: 1;
                background-color: hsl(0, 0%, 100%);
                border-radius: 0.375em;
                padding: 40px;
                box-shadow: 0 0 0 1px hsla(230, 13%, 9%, 0.02),
                    0 1px 3px -1px hsla(230, 13%, 9%, 0.2);
            }

            .alert-card__title {
                font-size: 1.375rem;
                display: flex;
                flex-wrap: wrap;
                gap: 0.5rem;
                align-items: center;
                padding-right: 2rem;
            }

            .alert-card__title .cd-icon {
                --size: 30px;
                color: hsl(35, 79%, 66%);
            }

            .alert-card__content {
                color: hsl(225, 4%, 47%);
                line-height: 1.58;
                font-size: 0.9375rem;
                margin: 0.75rem 0;
            }

            .alert-card__btns {
                display: flex;
                flex-direction: column;
                flex-wrap: wrap;
                gap: 0.75rem;
            }

            @media (min-width: 42.5rem) {
                .alert-card__btns {
                    flex-direction: row;
                }
            }

            .alert-card__close-btn {
                height: 32px;
                width: 32px;
                position: absolute;
                z-index: 1;
                top: 1.5rem;
                right: 1.5rem;
                display: flex;
                border-radius: 50%;
                transition: 0.2s;
            }

            .alert-card__close-btn .cd-icon {
                --size: 16px;
                margin: auto;
                display: block;
            }

            .alert-card__close-btn:hover {
                background-color: hsla(230, 13%, 9%, 0.1);
            }

            /* -------------------------------- 
            
            Utilities 
            
            -------------------------------- */

            .cd-hide {
                display: none;
            }
        </style>
        <style>

            /* component */
            :root {
                --author-img-size: 4em;
            }

            .author {
                display: grid;
                grid-template-columns: var(--author-img-size) 1fr;
                grid-gap: var(--ae2-space-sm);
            }

            .author__img-wrapper {
                display: inline-block;
                border-radius: 50%;
                width: var(--author-img-size);
                height: var(--author-img-size);
                overflow: hidden;
                transition: -webkit-transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
                transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
                transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1), -webkit-transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            }
            .author__img-wrapper:hover {
                -webkit-transform: scale(1.1);
                transform: scale(1.1);
            }
            .author__img-wrapper img {
                display: block;
                width: inherit;
                height: inherit;
                -o-object-fit: cover;
                object-fit: cover;
            }

            .author__content a {
                color: inherit;
            }
            .author__content a:hover {
                color: hsl(var(--ae2-color-primary-hsl));
            }

            .author--meta {
                --author-img-size: 3em;
                align-items: center;
                grid-gap: var(--ae2-space-xs);
            }

            .author--minimal {
                --author-img-size: 2.4em;
                align-items: center;
                grid-gap: var(--ae2-space-2xs);
            }

            .author--featured {
                --author-img-size: 6em;
                grid-template-columns: 1fr;
                justify-content: center;
                text-align: center;
            }
            .author--featured .author__img-wrapper {
                margin-left: auto;
                margin-right: auto;
            }

            .author__social {
                --ae2-size: 40px;
                width: var(--ae2-size);
                height: var(--ae2-size);
                display: flex;
                background-color: hsla(var(--ae2-color-contrast-higher-hsl), 0.1);
                border-radius: 50%;
                transition: 0.2s;
            }
            .author__social .ae2-icon {
                --ae2-size: 16px;
                display: block;
                margin: auto;
                color: hsl(var(--ae2-color-contrast-higher-hsl));
                transition: color 0.2s;
            }
            .author__social:hover {
                background-color: hsla(var(--ae2-color-contrast-higher-hsl), 0.075);
            }
            .author__social:hover .ae2-icon {
                color: hsl(var(--ae2-color-primary-hsl));
            }

            /* utility classes */
            .ae2-justify-center {
                justify-content: center;
            }

            .ae2-flex-wrap {
                flex-wrap: wrap;
            }

            .ae2-gap-xs {
                gap: var(--ae2-space-xs);
            }

            .ae2-flex {
                display: flex;
            }

            .ae2-text-component :where(h1, h2, h3, h4) {
                line-height: var(--ae2-heading-line-height, 1.2);
                margin-top: calc(var(--ae2-space-md) * var(--ae2-space-multiplier, 1));
                margin-bottom: calc(var(--ae2-space-sm) * var(--ae2-space-multiplier, 1));
            }

            .ae2-text-component :where(p, blockquote, ul li, ol li) {
                line-height: var(--ae2-body-line-height, 1.4);
            }

            .ae2-text-component :where(ul, ol, p, blockquote, .ae2-text-component__block) {
                margin-bottom: calc(var(--ae2-space-sm) * var(--ae2-space-multiplier, 1));
            }

            .ae2-text-component :where(ul, ol) {
                padding-left: 1.25em;
            }

            .ae2-text-component ul :where(ul, ol), .ae2-text-component ol :where(ul, ol) {
                padding-left: 1em;
                margin-bottom: 0;
            }

            .ae2-text-component ul {
                list-style-type: disc;
            }

            .ae2-text-component ol {
                list-style-type: decimal;
            }

            .ae2-text-component img {
                display: block;
                margin: 0 auto;
            }

            .ae2-text-component figcaption {
                margin-top: calc(var(--ae2-space-xs) * var(--ae2-space-multiplier, 1));
                font-size: var(--ae2-text-sm);
                text-align: center;}

            .ae2-text-component em {
                font-style: italic;
            }

            .ae2-text-component strong {
                font-weight: bold;
            }

            .ae2-text-component s {
                text-decoration: line-through;
            }

            .ae2-text-component u {
                text-decoration: underline;
            }

            .ae2-text-component mark {
                background-color: hsla(var(--ae2-color-accent-hsl), 0.2);
                color: inherit;
            }

            .ae2-text-component blockquote {
                padding-left: 1em;
                border-left: 4px solid hsl(var(--ae2-color-contrast-lower-hsl));
                font-style: italic;
            }

            .ae2-text-component hr {
                margin: calc(var(--ae2-space-md) * var(--ae2-space-multiplier, 1)) auto;
                background: hsl(var(--ae2-color-contrast-lower-hsl));
                height: 1px;
            }

            .ae2-text-component > *:first-child {
                margin-top: 0;
            }

            .ae2-text-component > *:last-child {
                margin-bottom: 0;
            }

            .ae2-text-component.ae2-line-height-xs {
                --ae2-heading-line-height: 1;
                --ae2-body-line-height: 1.1;
            }

            .ae2-text-component.ae2-line-height-sm {
                --ae2-heading-line-height: 1.1;
                --ae2-body-line-height: 1.2;
            }

            .ae2-text-component.ae2-line-height-md {
                --ae2-heading-line-height: 1.15;
                --ae2-body-line-height: 1.4;
            }

            .ae2-text-component.ae2-line-height-lg {
                --ae2-heading-line-height: 1.22;
                --ae2-body-line-height: 1.58;
            }

            .ae2-text-component.ae2-line-height-xl {
                --ae2-heading-line-height: 1.3;
                --ae2-body-line-height: 1.72;
            }

            .ae2-max-width-adaptive-sm {
                max-width: 32rem;
            }

            @media(min-width: 48rem) {
                .ae2-max-width-adaptive-sm {
                    max-width: 48rem;
                }
            }

            .ae2-container {
                width: calc(100% - 2*var(--ae2-space-md));
                margin-left: auto;
                margin-right: auto;
            }

            .ae2-color-contrast-medium {
                --ae2-color-o: 1;
                color: hsla(var(--ae2-color-contrast-medium-hsl), var(--ae2-color-o, 1));
            }

            .ae2-text-sm {
                font-size: var(--ae2-text-sm);
            }

            .ae2-text-base {
                font-size: var(--ae2-text-base);
            }

            .ae2-text-gap-2xs {
                --ae2-space-multiplier: 0.25;
            }
            .author--meta img{
                margin-right: 13px;
            }
        </style>
        <style>
            /* reset */
            *, *::after, *::before {
                box-sizing: border-box;
            }
            /* icons */
            .ak6-icon {
                height: var(--ak6-size, 1em);
                width: var(--ak6-size, 1em);
                display: inline-block;
                color: inherit;
                fill: currentColor;
                line-height: 1;
                flex-shrink: 0;
                max-width: initial;
                margin-left: 7px;
            }

            /* component */
            :root {
                /* general */
                --accordion-border-width: 1px;
                /* icon */
                --accordion-icon-size: 20px;
                --accordion-icon-stroke-width: 2px;
            }

            .accordion__item:first-child {
                border-top-width: var(--accordion-border-width);
            }

            .accordion__header {
                /* button */
                width: 100%;
                display: flex;
                align-items: center;
                justify-content: space-between;
                text-align: left;
                cursor: pointer;
            }
            .accordion__header svg {
                height: var(--accordion-icon-size);
                width: var(--accordion-icon-size);
            }
            .accordion__header svg .icon__group {
                stroke-width: var(--accordion-icon-stroke-width);
            }

            .accordion__icon-arrow .icon__group {
                will-change: transform;
                -webkit-transform-origin: 50% 50%;
                transform-origin: 50% 50%;
            }

            .accordion__icon-arrow .icon__group > * {
                -webkit-transform-origin: 10px 14px;
                transform-origin: 10px 14px;
            }


            .accordion__item--is-open > .accordion__header > .accordion__icon-arrow .icon__group > *:first-child {
                -webkit-transform: translateY(-8px) rotate(-90deg);
                transform: translateY(-8px) rotate(-90deg);
            }
            .accordion__item--is-open > .accordion__header > .accordion__icon-arrow .icon__group > *:last-child {
                -webkit-transform: translateY(-8px) rotate(90deg);
                transform: translateY(-8px) rotate(90deg);
            }

            .accordion__panel {
                display: none;
                will-change: height;
                -webkit-transform: translateZ(0px);
                transform: translateZ(0px);
                transition:  .9s;
            }

            .accordion__item--is-open > .accordion__panel {
                display: block;
            }

            /* animations */
            .accordion[data-animation=on] .accordion__item--is-open .accordion__panel > * {
                -webkit-animation: accordion-entry-animation 0.8s cubic-bezier(0.215, 0.61, 0.355, 1);
                animation: accordion-entry-animation 0.8s cubic-bezier(0.215, 0.61, 0.355, 1);
            }
            .accordion[data-animation=on] .accordion__icon-arrow .icon__group {
                transition: -webkit-transform 0.8s cubic-bezier(0.215, 0.61, 0.355, 1);
                transition: transform 0.8s cubic-bezier(0.215, 0.61, 0.355, 1);
                transition: transform 0.8s cubic-bezier(0.215, 0.61, 0.355, 1), -webkit-transform 0.3s cubic-bezier(0.215, 0.61, 0.355, 1);
            }
            .accordion[data-animation=on] .accordion__icon-arrow .icon__group > *{
                transition: stroke-dashoffset 0.8s, -webkit-transform 0.3s;
                transition: transform 0.8s, stroke-dashoffset 0.3s;
                transition: transform 0.8s, stroke-dashoffset 0.3s, -webkit-transform 0.3s;
                transition-timing-function: cubic-bezier(0.215, 0.61, 0.355, 1);
            }

            @-webkit-keyframes accordion-entry-animation {
                from {
                    opacity: 0;
                    -webkit-transform: translateY(-10px);
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    -webkit-transform: translateY(0px);
                    transform: translateY(0px);
                }
            }

            @keyframes accordion-entry-animation {
                from {
                    opacity: 0;
                    -webkit-transform: translateY(-10px);
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    -webkit-transform: translateY(0px);
                    transform: translateY(0px);
                }
            }

            /* utility classes */
            .ak6-text-component :where(h1, h2, h3, h4) {

                margin-top: calc(var(--ak6-space-md) * var(--ak6-space-multiplier, 1));
                margin-bottom: calc(var(--ak6-space-sm) * var(--ak6-space-multiplier, 1));
            }


            .ak6-text-component :where(ul, ol, p, blockquote, .ak6-text-component__block) {
                margin-bottom: calc(var(--ak6-space-sm) * var(--ak6-space-multiplier, 1));
            }

            .ak6-text-component :where(ul, ol) {
                padding-left: 1.25em;
            }

            .ak6-text-component ul :where(ul, ol), .ak6-text-component ol :where(ul, ol) {
                padding-left: 1em;
                margin-bottom: 0;
            }

            .ak6-text-component ul {
                list-style-type: disc;
            }

            .ak6-text-component ol {
                list-style-type: decimal;
            }

            .ak6-text-component img {
                display: block;
                margin: 0 auto;
            }

            .ak6-text-component figcaption {
                margin-top: calc(var(--ak6-space-xs) * var(--ak6-space-multiplier, 1));
                font-size: var(--ak6-text-sm);
                text-align: center;}

            .ak6-text-component em {
                font-style: italic;
            }

            .ak6-text-component strong {
                font-weight: bold;
            }

            .ak6-text-component s {
                text-decoration: line-through;
            }



            .ak6-text-component > *:first-child {
                margin-top: 0;
            }

            .ak6-text-component > *:last-child {
                margin-bottom: 0;
            }

            .ak6-text-component.ak6-line-height-xs {
                --ak6-heading-line-height: 1;
                --ak6-body-line-height: 1.1;
            }

            .ak6-text-component.ak6-line-height-sm {
                --ak6-heading-line-height: 1.1;
                --ak6-body-line-height: 1.2;
            }

            .ak6-text-component.ak6-line-height-md {
                --ak6-heading-line-height: 1.15;
                --ak6-body-line-height: 1.4;
            }

            .ak6-text-component.ak6-line-height-lg {
                --ak6-heading-line-height: 1.22;
                --ak6-body-line-height: 1.58;
            }

            .ak6-text-component.ak6-line-height-xl {
                --ak6-heading-line-height: 1.3;
                --ak6-body-line-height: 1.72;
            }

            .ak6-padding-bottom-md {
                padding-bottom: var(--ak6-space-md);
            }

            .ak6-padding-x-md {
                padding-left: var(--ak6-space-md);
                padding-right: var(--ak6-space-md);
            }

            .ak6-padding-top-2xs {
                padding-top: var(--ak6-space-2xs);
            }

            .ak6-text-md {
                font-size: var(--ak6-text-md);
            }

            .ak6-padding-y-sm {
                padding-top: var(--ak6-space-sm);
                padding-bottom: var(--ak6-space-sm);
            }
        </style>
        <style>

            p{
                font-size: 13px;
            }
            .author__content{
                font-size: 17px;
                margin-left: 15px;
            }
            .textoPost{ /* contenido del post */
                font-size: 14px;
            }
            .accordion__header{
                font-size: 16px;
            }
            .textarea{
                font-size: 15px;
            }
            /*COMENTARIOS DEL POST, IMG */
            .chip {
                /* reset */
                border: 0;
                color: inherit;
                line-height: 1;
                -webkit-appearance: none;
                appearance: none;

                display: inline-flex;
                align-items: center;
                border-radius: 50em;
                padding: 0.25rem;
                background-color: hsla(230, 13%, 9%, 0.1);

                font-size: 0.9375rem;
            }
            .chip__label {
                padding: 0 0.5rem;
            }

            .chip__img {
                display: block;
                width: 1.5em;
                height: 1.5em;
                border-radius: 50%;
                -o-object-fit: cover;
                object-fit: cover;
            }

            .cd-demo-chip-list {
                margin-bottom: 2rem;
                display: flex;
                flex-wrap: wrap;
                gap: 0.75rem;
            }

            .cd-icon {
                --size: 1em;
                font-size: var(--size);
                height: 1em;
                width: 1em;
                display: inline-block;
                color: inherit;
                fill: currentColor;
                line-height: 1;
                flex-shrink: 0;
                max-width: initial;
            }

            .cd-icon use { /* SVG symbols - enable icon color corrections */
                color: inherit;
                fill: currentColor;
            }
            .ak6-text-component ul{
                margin-bottom: 2px;
            }
            /* -------------------------------- 

File#: _2_form-example
Title: Form Example 
Descr: How to include basic form elements
Usage: codyhouse.co/license

-------------------------------- */
            /* reset */
            *, *::after, *::before {
                box-sizing: border-box;
            }


            ol, ul, menu {
                list-style: none;
            }

            button, input, textarea, select {
                background-color: transparent;
                border-radius: 0;
                color: inherit;
                line-height: inherit;
                appearance: none;
            }

            textarea {
                resize: vertical;
                overflow: auto;
                vertical-align: top;
            }

            a {
                color: hsl(250, 84%, 54%);
            }

            table {
                border-collapse: collapse;
                border-spacing: 0;
            }

            img, video, svg {
                display: block;
                max-width: 100%;
            }

            @media (min-width: 64rem) {
                body {
                    font-size: 1.25rem;
                }

                h1 {
                    font-size: 3.051rem;
                }

                h2 {
                    font-size: 2.44rem;
                }

                h3 {
                    font-size: 1.75rem;
                }

                h4 {
                    font-size: 1.5625rem;
                }
            }

            /* variables */
            :root {
                /* colors */
                --fw3-color-primary-hsl: 250, 84%, 54%;
                --fw3-color-bg-hsl: 0, 0%, 100%;
                --fw3-color-contrast-high-hsl: 230, 7%, 23%;
                --fw3-color-contrast-higher-hsl: 230, 13%, 9%;
                --fw3-color-error-hsl: 342, 89%, 48%;
                --fw3-color-contrast-medium-hsl: 225, 4%, 47%;
                --fw3-color-bg-dark-hsl: 240, 4%, 95%;
                --fw3-color-white-hsl: 0, 0%, 100%;
                --fw3-color-primary-darker-hsl: 250, 84%, 38%;
                --fw3-color-primary-light-hsl: 250, 84%, 60%;
                --fw3-color-contrast-lower-hsl: 240, 4%, 85%;
                --fw3-color-contrast-low-hsl: 240, 4%, 65%;

                /* spacing */
                --fw3-space-3xs: 0.25rem;
                --fw3-space-2xs: 0.375rem;
                --fw3-space-xs: 0.5rem;
                --fw3-space-sm: 0.75rem;
                --fw3-space-md: 1.25rem;

                /* typography */
                --fw3-text-sm: 0.833rem;
                --fw3-text-xs: 0.694rem;
                --fw3-text-md: 1.2rem;
            }

            @media(min-width: 64rem){
                :root {
                    /* spacing */
                    --fw3-space-3xs: 0.375rem;
                    --fw3-space-2xs: 0.5625rem;
                    --fw3-space-xs: 0.75rem;
                    --fw3-space-sm: 1.125rem;
                    --fw3-space-md: 2rem;

                    /* typography */
                    --fw3-text-sm: 1rem;
                    --fw3-text-xs: 0.8rem;
                    --fw3-text-md: 1.5625rem;
                }
            }

            /* buttons */
            .fw3-btn {
                position: relative;
                display: inline-flex;
                justify-content: center;
                align-items: center;
                white-space: nowrap;
                text-decoration: none;
                background: hsl(var(--fw3-color-bg-dark-hsl));
                color: hsl(var(--fw3-color-contrast-higher-hsl));
                cursor: pointer;
                text-decoration: none;
                line-height: 1.2;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
                transition: all 0.2s ease;
                will-change: transform;
                padding: var(--fw3-space-2xs) var(--fw3-space-sm);
                border-radius: 0.25em;
            }

            .fw3-btn:focus-visible {
                box-shadow: 0px 0px 0px 2px hsl(var(--fw3-color-bg-hsl)), 0px 0px 0px 4px hsla(var(--fw3-color-contrast-higher-hsl), 0.15);
                outline: none;
            }

            .fw3-btn:active {
                transform: translateY(2px);
            }

            .fw3-btn--primary {
                background: #231942;
                color: hsl(var(--fw3-color-white-hsl));
                box-shadow: inset 0px 1px 0px hsla(var(--fw3-color-white-hsl), 0.15), 0px 1px 3px hsla(var(--fw3-color-primary-darker-hsl), 0.25), 0px 2px 6px hsla(var(--fw3-color-primary-darker-hsl), 0.1), 0px 6px 10px -2px hsla(var(--fw3-color-primary-darker-hsl), 0.25);
            }

            .fw3-btn--primary:hover {
                background: hsl(var(--fw3-color-primary-light-hsl));
                box-shadow: inset 0px 1px 0px hsla(var(--fw3-color-white-hsl), 0.15), 0px 1px 2px hsla(var(--fw3-color-primary-darker-hsl), 0.25), 0px 1px 4px hsla(var(--fw3-color-primary-darker-hsl), 0.1), 0px 3px 6px -2px hsla(var(--fw3-color-primary-darker-hsl), 0.25);
            }

            .fw3-btn--primary:focus {
                box-shadow: inset 0px 1px 0px hsla(var(--fw3-color-white-hsl), 0.15), 0px 1px 2px hsla(var(--fw3-color-primary-darker-hsl), 0.25), 0px 1px 4px hsla(var(--fw3-color-primary-darker-hsl), 0.1), 0px 3px 6px -2px hsla(var(--fw3-color-primary-darker-hsl), 0.25), 0px 0px 0px 2px hsl(var(--fw3-color-bg-hsl)), 0px 0px 0px 4px hsl(var(--fw3-color-primary-hsl));
            }

            /* form elements */
            .fw3-form-control {
                padding: var(--fw3-space-2xs) var(--fw3-space-xs);
                background: #E0E1DD;
                line-height: 1.2;
                box-shadow: inset 0px 0px 0px 1px hsl(var(--fw3-color-contrast-lower-hsl));
                transition: all 0.2s ease;
                border-radius: 0.25em;
            }

            .fw3-form-control::placeholder {
                opacity: 1;
                color: hsl(var(--fw3-color-contrast-low-hsl));
            }

            .fw3-form-control:focus, .fw3-form-control:focus-within {
                background: hsl(var(--fw3-color-bg-hsl));
                box-shadow: inset 0px 0px 0px 1px hsla(var(--fw3-color-contrast-lower-hsl), 0), 0px 0px 0px 2px hsl(var(--fw3-color-primary-hsl)), 0 0.3px 0.4px rgba(0, 0, 0, 0.025),0 0.9px 1.5px rgba(0, 0, 0, 0.05), 0 3.5px 6px rgba(0, 0, 0, 0.1);
                outline: none;
            }

            .fw3-form-control.fw3-form-control--error {
                box-shadow: inset 0px 0px 0px 1px hsla(var(--fw3-color-contrast-lower-hsl), 0), 0px 0px 0px 2px hsl(var(--fw3-color-error-hsl));
            }

            .fw3-form-control.fw3-form-control--error:focus, .fw3-form-control.fw3-form-control--error:focus-within {
                box-shadow: inset 0px 0px 0px 1px hsla(var(--fw3-color-contrast-lower-hsl), 0), 0px 0px 0px 2px hsl(var(--fw3-color-error-hsl)), 0 0.3px 0.4px rgba(0, 0, 0, 0.025),0 0.9px 1.5px rgba(0, 0, 0, 0.05), 0 3.5px 6px rgba(0, 0, 0, 0.1);
            }

            .fw3-form-legend {
                color: hsl(var(--fw3-color-contrast-higher-hsl));
                line-height: 1.2;
                font-size: var(--fw3-text-md);
                margin-bottom: var(--fw3-space-sm);
            }

            .fw3-form-label {
                display: inline-block;
                font-size: var(--fw3-text-sm);
            }

            /* component */


            /* utility classes */
            .fw3-gap-md {
                gap: var(--fw3-space-md);
            }

            .fw3-flex-wrap {
                flex-wrap: wrap;
            }

            .fw3-flex {
                display: flex;
            }

            .fw3-margin-bottom-md {
                margin-bottom: var(--fw3-space-md);
            }

            .fw3-gap-3xs {
                gap: var(--fw3-space-3xs);
            }

            .fw3-flex-column {
                flex-direction: column;
            }

            .fw3-margin-top-2xs {
                margin-top: var(--fw3-space-2xs);
            }

            .fw3-color-contrast-medium {
                --fw3-color-o: 1;
                color: hsla(var(--fw3-color-contrast-medium-hsl), var(--fw3-color-o, 1));
            }

            .fw3-text-xs {
                font-size: var(--fw3-text-xs);
            }

            .fw3-width-100\% {
                width: 100%;
            }

            .fw3-margin-bottom-2xs {
                margin-bottom: var(--fw3-space-2xs);
            }

            .fw3-color-contrast-higher {
                --fw3-color-o: 1;
                color: hsla(var(--fw3-color-contrast-higher-hsl), var(--fw3-color-o, 1));
            }

            .fw3-text-sm {
                font-size: var(--fw3-text-sm);
            }

            .fw3-radius-md {
                border-radius: 0.25em;
            }

            .fw3-padding-xs {
                padding: var(--fw3-space-xs);
            }

            .fw3-bg-error {
                --fw3-bg-o: 1;
                background-color: #dee2e6;
            }

            .fw3-gap-sm {
                gap: var(--fw3-space-sm);
            }

            .fw3-grid {
                display: grid;
                grid-template-columns: repeat(12, 1fr);
            }

            .fw3-grid > * {
                min-width: 0;
                grid-column-end: span 12;
            }

            .fw3-bg-opacity-20\% {
                --fw3-bg-o: 0.2;
            }

            @media(min-width: 64rem){
                .fw3-col-6\@md {
                    grid-column-end: span 6;
                }
            }
        </style>
        <style>

            /* component */
            .modal {
                position: fixed;
                z-index: 15;
                width: 100%;
                height: 100%;
                left: 0;
                top: 0;
                opacity: 0;
                visibility: hidden;
            }
            .modal:not(.modal--is-visible) {
                pointer-events: none;
                background-color: transparent;
            }

            .modal--is-visible {
                opacity: 1;
                visibility: visible;
            }

            /* close button */
            .modal__close-btn {
                display: flex;
                flex-shrink: 0;
                border-radius: 50%;
                transition: 0.2s;
            }
            .modal__close-btn svg {
                display: block;
                margin: auto;
            }

            .modal__close-btn--outer {
                /* close button - outside the modal__content */
                width: 48px;
                height: 48px;
                position: fixed;
                top: var(--mc4-space-sm);
                right: var(--mc4-space-sm);
                z-index: 10;
                background-color: hsla(var(--mc4-color-black-hsl), 0.9);
                transition: 0.2s;
            }
            .modal__close-btn--outer svg {
                color: hsl(var(--mc4-color-white-hsl));
                /* icon color */
                transition: -webkit-transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
                transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
                transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1), -webkit-transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
            }
            .modal__close-btn--outer:hover {
                background-color: hsla(var(--mc4-color-black-hsl), 1);
            }
            .modal__close-btn--outer:hover svg {
                -webkit-transform: scale(1.1);
                transform: scale(1.1);
            }

            .modal__close-btn--inner {
                /* close button - inside the modal__content */
                --mc4-size: 32px;
                width: var(--mc4-size);
                height: var(--mc4-size);
                background-color: hsl(var(--mc4-color-bg-light-hsl));
                box-shadow: inset 0 0 0.5px 1px hsla(0, 0%, 100%, 0.075), 0 0.3px 0.4px rgba(0, 0, 0, 0.025),0 0.9px 1.5px rgba(0, 0, 0, 0.05), 0 3.5px 6px rgba(0, 0, 0, 0.1);
                transition: 0.2s;
            }
            .modal__close-btn--inner svg {
                color: inherit;
                /* icon color */
            }
            .modal__close-btn--inner:hover {
                background-color: hsl(var(--mc4-color-bg-lighter-hsl));
                box-shadow: inset 0 0 0.5px 1px hsla(0, 0%, 100%, 0.075), 0 0.9px 1.5px rgba(0, 0, 0, 0.03),0 3.1px 5.5px rgba(0, 0, 0, 0.08),0 14px 25px rgba(0, 0, 0, 0.12);
            }

            /* animations */
            :root {
                --modal-transition-duration: 0.2s;
                /* fallback (i.e., unless specified differently in the variations 👇) */
            }

            @media (prefers-reduced-motion: no-preference) {
                .modal--animate-fade {
                    --modal-transition-duration: 0.2s;
                    transition: opacity var(--modal-transition-duration), background-color var(--modal-transition-duration), visibility 0s var(--modal-transition-duration);
                }
                .modal--animate-fade.modal--is-visible {
                    transition: opacity var(--modal-transition-duration), background-color var(--modal-transition-duration), visibility 0s;
                }

                .modal--animate-scale,
                .modal--animate-translate-up,
                .modal--animate-translate-down,
                .modal--animate-translate-right,
                .modal--animate-translate-left {
                    --modal-transition-duration: 0.2s;
                    transition: opacity var(--modal-transition-duration), background-color var(--modal-transition-duration), visibility 0s var(--modal-transition-duration);
                }
                .modal--animate-scale .modal__content,
                .modal--animate-translate-up .modal__content,
                .modal--animate-translate-down .modal__content,
                .modal--animate-translate-right .modal__content,
                .modal--animate-translate-left .modal__content {
                    will-change: transform;
                    transition: -webkit-transform var(--modal-transition-duration) cubic-bezier(0.215, 0.61, 0.355, 1);
                    transition: transform var(--modal-transition-duration) cubic-bezier(0.215, 0.61, 0.355, 1);
                    transition: transform var(--modal-transition-duration) cubic-bezier(0.215, 0.61, 0.355, 1), -webkit-transform var(--modal-transition-duration) cubic-bezier(0.215, 0.61, 0.355, 1);
                }
                .modal--animate-scale.modal--is-visible,
                .modal--animate-translate-up.modal--is-visible,
                .modal--animate-translate-down.modal--is-visible,
                .modal--animate-translate-right.modal--is-visible,
                .modal--animate-translate-left.modal--is-visible {
                    transition: opacity var(--modal-transition-duration), background-color var(--modal-transition-duration), visibility 0s;
                }
                .modal--animate-scale.modal--is-visible .modal__content,
                .modal--animate-translate-up.modal--is-visible .modal__content,
                .modal--animate-translate-down.modal--is-visible .modal__content,
                .modal--animate-translate-right.modal--is-visible .modal__content,
                .modal--animate-translate-left.modal--is-visible .modal__content {
                    -webkit-transform: scale(1);
                    transform: scale(1);
                    /* reset all transformations */
                }

                .modal--animate-slide-up,
                .modal--animate-slide-down,
                .modal--animate-slide-right,
                .modal--animate-slide-left {
                    --modal-transition-duration: 0.3s;
                    transition: opacity 0s var(--modal-transition-duration), background-color var(--modal-transition-duration), visibility 0s var(--modal-transition-duration);
                }
                .modal--animate-slide-up .modal__content,
                .modal--animate-slide-down .modal__content,
                .modal--animate-slide-right .modal__content,
                .modal--animate-slide-left .modal__content {
                    will-change: transform;
                    transition: -webkit-transform var(--modal-transition-duration) cubic-bezier(0.215, 0.61, 0.355, 1);
                    transition: transform var(--modal-transition-duration) cubic-bezier(0.215, 0.61, 0.355, 1);
                    transition: transform var(--modal-transition-duration) cubic-bezier(0.215, 0.61, 0.355, 1), -webkit-transform var(--modal-transition-duration) cubic-bezier(0.215, 0.61, 0.355, 1);
                }
                .modal--animate-slide-up.modal--is-visible,
                .modal--animate-slide-down.modal--is-visible,
                .modal--animate-slide-right.modal--is-visible,
                .modal--animate-slide-left.modal--is-visible {
                    transition: background-color var(--modal-transition-duration), visibility 0s;
                }
                .modal--animate-slide-up.modal--is-visible .modal__content,
                .modal--animate-slide-down.modal--is-visible .modal__content,
                .modal--animate-slide-right.modal--is-visible .modal__content,
                .modal--animate-slide-left.modal--is-visible .modal__content {
                    -webkit-transform: scale(1);
                    transform: scale(1);
                    /* reset all transformations */
                }

                /* scale */
                .modal--animate-scale .modal__content {
                    -webkit-transform: scale(0.95);
                    transform: scale(0.95);
                }

                /* translate */
                .modal--animate-translate-up .modal__content {
                    -webkit-transform: translateY(40px);
                    transform: translateY(40px);
                }

                .modal--animate-translate-down .modal__content {
                    -webkit-transform: translateY(-40px);
                    transform: translateY(-40px);
                }

                .modal--animate-translate-right .modal__content {
                    -webkit-transform: translateX(-40px);
                    transform: translateX(-40px);
                }

                .modal--animate-translate-left .modal__content {
                    -webkit-transform: translateX(40px);
                    transform: translateX(40px);
                }

                /* slide */
                .modal--animate-slide-up .modal__content {
                    -webkit-transform: translateY(100%);
                    transform: translateY(100%);
                }

                .modal--animate-slide-down .modal__content {
                    -webkit-transform: translateY(-100%);
                    transform: translateY(-100%);
                }

                .modal--animate-slide-right .modal__content {
                    -webkit-transform: translateX(-100%);
                    transform: translateX(-100%);
                }

                .modal--animate-slide-left .modal__content {
                    -webkit-transform: translateX(100%);
                    transform: translateX(100%);
                }
            }
            /* load content - optional */
            .modal--is-loading .modal__content {
                visibility: hidden;
            }
            .modal--is-loading .modal__loader {
                display: flex;
            }

            .modal__loader {
                /* loader icon */
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                justify-content: center;
                align-items: center;
                display: none;
                pointer-events: none;
            }

            /* --image */
            .modal-img-btn {
                position: relative;
                cursor: pointer;
            }
            .modal-img-btn::after {
                content: "";
                position: absolute;
                z-index: 1;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: hsla(var(--mc4-color-black-hsl), 0);
                transition: background 0.2s;
            }
            .modal-img-btn:hover::after {
                background-color: hsla(var(--mc4-color-black-hsl), 0.7);
            }
            .modal-img-btn:hover .modal-img-btn__icon-wrapper {
                opacity: 1;
            }

            .modal-img-btn__icon-wrapper {
                position: absolute;
                z-index: 2;
                top: calc(50% - 24px);
                left: calc(50% - 24px);
                width: 48px;
                height: 48px;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
                background-color: hsla(var(--mc4-color-black-hsl), 0.7);
                opacity: 0;
                transition: opacity 0.2s;
            }
            .modal-img-btn__icon-wrapper .mc4-icon {
                color: hsl(var(--mc4-color-white-hsl));
            }

            /* utility classes */
            .mc4-max-width-100\% {
                max-width: 150rem;
            }

            .mc4-max-height-100\% {
                max-height: 100%;
            }

            .mc4-shadow-md {
                box-shadow:0 0.9px 1.5px rgba(0, 0, 0, 0.03),0 3.1px 5.5px rgba(0, 0, 0, 0.08),0 14px 25px rgba(0, 0, 0, 0.12);
            }

            .mc4-radius-md {
                border-radius: 0.25em;
            }

            .mc4-block {
                display: block;
            }

            .mc4-pointer-events-none {
                pointer-events: none;
            }

            .mc4-flex-center {
                justify-content: center;
                align-items: center;
            }

            .mc4-flex {
                display: flex;
            }

            .mc4-height-100\% {
                height: 100%;
            }

            .mc4-width-100\% {
                width: 100%;
            }

            .mc4-padding-md {
                padding: var(--mc4-space-md);
            }

            .mc4-bg-black {
                --mc4-bg-o: 1;
                background-color: hsla(var(--mc4-color-black-hsl), var(--mc4-bg-o, 1));
            }

            .mc4-width-3xl {
                width: 8rem;
            }

            .mc4-overflow-hidden {
                overflow: hidden;
            }

            .mc4-text-lg {
                font-size: var(--mc4-text-lg);
            }

            .mc4-text-component :where(h1, h2, h3, h4) {
                line-height: var(--mc4-heading-line-height, 1.2);
                margin-top: calc(var(--mc4-space-md) * var(--mc4-space-multiplier, 1));
                margin-bottom: calc(var(--mc4-space-sm) * var(--mc4-space-multiplier, 1));
            }

            .mc4-text-component :where(p, blockquote, ul li, ol li) {
                line-height: var(--mc4-body-line-height, 1.4);
            }

            .mc4-text-component :where(ul, ol, p, blockquote, .mc4-text-component__block) {
                margin-bottom: calc(var(--mc4-space-sm) * var(--mc4-space-multiplier, 1));
            }

            .mc4-text-component :where(ul, ol) {
                padding-left: 1.25em;
            }

            .mc4-text-component ul :where(ul, ol), .mc4-text-component ol :where(ul, ol) {
                padding-left: 1em;
                margin-bottom: 0;
            }

            .mc4-text-component ul {
                list-style-type: disc;
            }

            .mc4-text-component ol {
                list-style-type: decimal;
            }

            .mc4-text-component img {
                display: block;
                margin: 0 auto;
            }

            .mc4-text-component figcaption {
                margin-top: calc(var(--mc4-space-xs) * var(--mc4-space-multiplier, 1));
                font-size: var(--mc4-text-sm);
                text-align: center;}

            .mc4-text-component em {
                font-style: italic;
            }

            .mc4-text-component strong {
                font-weight: bold;
            }

            .mc4-text-component s {
                text-decoration: line-through;
            }

            .mc4-text-component u {
                text-decoration: underline;
            }

            .mc4-text-component mark {
                background-color: hsla(var(--mc4-color-accent-hsl), 0.2);
                color: inherit;
            }

            .mc4-text-component blockquote {
                padding-left: 1em;
                border-left: 4px solid hsl(var(--mc4-color-contrast-lower-hsl));
                font-style: italic;
            }

            .mc4-text-component hr {
                margin: calc(var(--mc4-space-md) * var(--mc4-space-multiplier, 1)) auto;
                background: hsl(var(--mc4-color-contrast-lower-hsl));
                height: 1px;
            }

            .mc4-text-component > *:first-child {
                margin-top: 0;
            }

            .mc4-text-component > *:last-child {
                margin-bottom: 0;
            }

            .mc4-text-component.mc4-line-height-xs {
                --mc4-heading-line-height: 1;
                --mc4-body-line-height: 1.1;
            }

            .mc4-text-component.mc4-line-height-sm {
                --mc4-heading-line-height: 1.1;
                --mc4-body-line-height: 1.2;
            }

            .mc4-text-component.mc4-line-height-md {
                --mc4-heading-line-height: 1.15;
                --mc4-body-line-height: 1.4;
            }

            .mc4-text-component.mc4-line-height-lg {
                --mc4-heading-line-height: 1.22;
                --mc4-body-line-height: 1.58;
            }

            .mc4-text-component.mc4-line-height-xl {
                --mc4-heading-line-height: 1.3;
                --mc4-body-line-height: 1.72;
            }

            .mc4-top-0 {
                top: 0;
            }

            .mc4-position-sticky {
                position: sticky;
            }

            .mc4-float-right {
                float: right;
            }

            :where(.mc4-inner-glow) {
                position: relative;
            }

            .mc4-inner-glow::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border-radius: inherit;
                pointer-events: none;
                box-shadow: inset 0 0 0.5px 1px hsla(0, 0%, 100%, 0.075);
            }

            .mc4-bg {
                --mc4-bg-o: 1;
                background-color: hsla(var(--mc4-color-bg-hsl), var(--mc4-bg-o, 1));
            }

            .mc4-overflow-auto {
                overflow: auto;
            }

            .mc4-max-width-sm {
                max-width: 48rem;
            }

            @media not all and (min-width: 64rem) {
                .mc4-display\@md {
                    display:none !important;
                }
            }

            .mc4-gap-xs {
                gap: var(--mc4-space-xs);
            }

            .mc4-justify-end {
                justify-content: flex-end;
            }

            .mc4-padding-x-md {
                padding-left: var(--mc4-space-md);
                padding-right: var(--mc4-space-md);
            }

            .mc4-padding-y-sm {
                padding-top: var(--mc4-space-sm);
                padding-bottom: var(--mc4-space-sm);
            }

            .mc4-text-md {
                font-size: var(--mc4-text-md);
            }

            .mc4-text-truncate {
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .mc4-justify-between {
                justify-content: space-between;
            }

            .mc4-items-center {
                align-items: center;
            }

            .mc4-bg-contrast-lower {
                --mc4-bg-o: 1;
                background-color: hsla(var(--mc4-color-contrast-lower-hsl), var(--mc4-bg-o, 1));
            }

            .mc4-max-width-xs {
                max-width: 38rem;
            }

            .mc4-flex-shrink-0 {
                flex-shrink: 0;
            }

            :where(.mc4-inner-glow-top) {
                position: relative;
            }

            .mc4-inner-glow-top::after {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border-radius: inherit;
                pointer-events: none;
                box-shadow: var(inset 0 1px 0.5px hsla(0, 0%, 100%, 0.075));
            }

            .mc4-momentum-scrolling {
                -webkit-overflow-scrolling: touch;
            }

            .mc4-flex-grow {
                flex-grow: 1;
            }

            .mc4-flex-column {
                flex-direction: column;
            }

            .mc4-bg-opacity-90\% {
                --mc4-bg-o: 0.9;
            }

            .mc4-bg-opacity-50\% {
                --mc4-bg-o: 0.5;
            }

            @media(min-width: 64rem){
                .mc4-hide\@md {
                    display: none !important;
                }
            }
        </style>
    </head>
    <body style=" background-image: url('https://d3ae4wrz2ljkbq.cloudfront.net/components/img-16-9-dark-1.svg'); background-size: cover; background-repeat: no-repeat;">
        <header>
            <nav class="cd-stretchy-nav add-content">
                <button class="mc4-btn mc4-btn--primary" aria-controls="modal-name-1">Show modal window</button>

                <div id="modal-name-1" class="modal modal--animate-scale mc4-flex mc4-flex-center mc4-bg-black mc4-bg-opacity-90% mc4-padding-md js-modal">
                    <div class="modal__content mc4-width-100% mc4-max-width-xs mc4-max-height-100% mc4-overflow-auto mc4-bg mc4-radius-md mc4-inner-glow mc4-shadow-md" role="alertdialog" aria-labelledby="modal-title-1" aria-describedby="modal-description-1">
                        <header class="mc4-bg-contrast-lower mc4-bg-opacity-50% mc4-padding-y-sm mc4-padding-x-md mc4-flex mc4-items-center mc4-justify-between">
                            <h1 id="modal-title-1" class="mc4-text-truncate mc4-text-md">Modal title</h1>

                            <button class="modal__close-btn modal__close-btn--inner mc4-hide@md js-modal__close js-tab-focus">
                                <svg class="mc4-icon mc4-icon--xs" viewBox="0 0 16 16">
                                <title>Close modal window</title>
                                <g stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-miterlimit="10">
                                <line x1="13.5" y1="2.5" x2="2.5" y2="13.5"></line>
                                <line x1="2.5" y1="2.5" x2="13.5" y2="13.5"></line>
                                </g>
                                </svg>
                            </button>
                        </header>

                        <div class="mc4-padding-y-sm mc4-padding-x-md">
                            <div class="mc4-text-component">
                                <p id="modal-description-1">Lorem ipsum dolor sit amet consectetur adipisicing elit. Vitae culpa, inventore alias ab atque similique quod ea reprehenderit.</p>
                            </div>
                        </div>

                        <footer class="mc4-padding-md">
                            <div class="mc4-flex mc4-justify-end mc4-gap-xs">
                                <button class="mc4-btn mc4-btn--subtle js-modal__close">Cancel</button>
                                <button class="mc4-btn mc4-btn--primary">Install</button>
                            </div>
                        </footer>
                    </div>

                    <button class="modal__close-btn modal__close-btn--outer mc4-display@md js-modal__close js-tab-focus">
                        <svg class="mc4-icon mc4-icon--sm" viewBox="0 0 24 24">
                        <title>Close modal window</title>
                        <g fill="none" stroke="currentColor" stroke-miterlimit="10" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="3" y1="3" x2="21" y2="21" />
                        <line x1="21" y1="3" x2="3" y2="21" />
                        </g>
                        </svg>
                    </button>
                </div>
            </nav>
        </header>

        <!-- ______________________________________________________________ HERO INFO CLASS  _______________________________________________________________________-->
        <div>
            <div>
                <section class="hero hero--center" style="background-image: url('https://d3ae4wrz2ljkbq.cloudfront.net/components/img-16-9-dark-1.svg'); ">
                    <div class="cd-container cd-max-width-adaptive-sm" >
                        <h1 class="cd-margin-bottom-xs" style="color: white;">Foro de clase</h1>
                        <p class="cd-line-height-lg cd-margin-bottom-sm">Número de estudiantes:</p>
                        
                    </div>
                </section>
            </div>

            <!-- ______________________________________________________________ POST  _______________________________________________________________________-->    
            <%                while (post.next()) {
                    int id_postito = post.getInt(1);
                    String coments = "Select * from Comentarios where id_post = '" + id_postito + "'"; // NOTA: el id_foro es igual al id_class pues al crear una clase tambien se crea su foro
                    ResultSet cajitaComent = basesita.consulta(coments);

            %>
            <div class="alert-card js-alert-card">
                <div class="author author--meta">
                    <a href="#0" class="author__img-wrapper">
                        <img src="../../Img/fotos_perfil/Orion_foto.png" alt="Author picture">
                    </a>
                    <div class="author__content ae2-text-component ae2-text-gap-2xs">
                        <h4 class="ae2-text-base"><a href="#0" rel="author"><%=post.getString(2)%></a></h4>
                        <p class="ae2-text-sm ae2-color-contrast-medium"><time><!--fecha--></time> </p>
                    </div>
                </div>

                <div>
                    <!-- _________________ TEXTO DEL POST  __________________-->
                    <p class="alert-card__content">
                        <%=post.getString(3)%>
                    </p>
                    <!-- _________________ LISTA DESPLEGABLE DE COMENTARIOS  __________________-->
                    <div class="alert-card__btns">
                        <ul class="accordion  js-accordion" data-animation="on" data-multi-items="on">
                            <li class="accordion__item accordion__item--is-open js-accordion__item">
                                <button class="accordion__header ak6-padding-y-sm ak6-padding-x-md js-tab-focus" type="button">
                                    <span class="ak6-text-md" >Ver comentarios</span>
                                    <svg class="ak6-icon accordion__icon-arrow " viewBox="0 0 20 20" aria-hidden="true">
                                    <g class="icon__group" fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round">
                                    <line x1="10" y1="14" x2="3" y2="7" />
                                    <line x1="17" y1="7" x2="10" y2="14" />
                                    </g>
                                    </svg>
                                </button>
                                <div class="accordion__panel ak6-padding-top-2xs ak6-padding-x-md ak6-padding-bottom-md js-accordion__panel">
                                    <div class="ak6-text-component">
                                        <div>
                                            <%
                                                if (post.getString(3) == null) {
                                                }
                                                while (cajitaComent.next()) {
                                            %>
                                            <!-- _________________ COMENTARIO  __________________-->
                                            <ul class="cd-demo-chip-list" style="list-style-type: none;">
                                                <div class="fw3-bg-error fw3-bg-opacity-20% fw3-padding-xs fw3-radius-md fw3-text-sm fw3-color-contrast-higher fw3-margin-top-2xs" role="alert">
                                                    <li>
                                                        <span class="chip">
                                                            <img class="chip__img" src="../../Img/fotos_perfil/equipo_yaz.jpeg" alt="Picture of Olivia Saturday">
                                                            <i class="chip__label"><%=cajitaComent.getString(2)%></i>
                                                        </span>
                                                    </li>
                                                    <p><%=cajitaComent.getString(3)%></p>
                                                </div>
                                            </ul>
                                            <%
                                                }
                                            %>
                                        </div>

                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <!-- _________________ FORM COMENTAR POST  __________________-->
                    <div>
                        <form name="form" action="comentar/Insert_comentario.jsp" method="post" > 
                            <label class="fw3-form-label fw3-margin-bottom-2xs" for="textarea"><b>Comentar publicación</b> </label>
                            <textarea class="fw3-form-control fw3-width-100%" name="textarea" id="textarea"></textarea>
                            <p class="fw3-text-xs fw3-color-contrast-medium fw3-margin-top-2xs">No escribas cosas feas porfa</p>
                            <div>
                                <button class="fw3-btn fw3-btn--primary">Comentar</button>
                            </div>
                        </form>
                    </div>
                </div>
                <!-- _________________ BOTON EDIT  __________________-->
                <button class="alert-card__close-btn js-alert-card__close-btn">
                    <i class='bx bx-edit icon'></i>
                </button>
            </div>



            <%                    }

                        post.close();
                        basesita.cierraConexion();
                    } catch (Exception ex) {
                        out.print(ex.getMessage());
                    }

                }
                Dato_idClase.close();
            %>





        </div>
        <script src="../../js/jquery-2.1.4.js"></script>
        <script>
            jQuery(document).ready(function () {
                if ($('.cd-stretchy-nav').length > 0) {
                    var stretchyNavs = $('.cd-stretchy-nav');

                    stretchyNavs.each(function () {
                        var stretchyNav = $(this),
                                stretchyNavTrigger = stretchyNav.find('.cd-nav-trigger');

                        stretchyNavTrigger.on('click', function (event) {
                            event.preventDefault();
                            stretchyNav.toggleClass('nav-is-visible');
                        });
                    });

                    $(document).on('click', function (event) {
                        (!$(event.target).is('.cd-nav-trigger') && !$(event.target).is('.cd-nav-trigger span')) && stretchyNavs.removeClass('nav-is-visible');
                    });
                }
            });
        </script>
        <script>
            // File#: _1_accordion
            // Usage: codyhouse.co/license
            (function () {
                var Accordion = function (element) {
                    this.element = element;
                    this.items = getChildrenByClassName(this.element, 'js-accordion__item');
                    this.version = this.element.getAttribute('data-version') ? '-' + this.element.getAttribute('data-version') : '';
                    this.showClass = 'accordion' + this.version + '__item--is-open';
                    this.animateHeight = (this.element.getAttribute('data-animation') == 'on');
                    this.multiItems = !(this.element.getAttribute('data-multi-items') == 'off');
                    // deep linking options
                    this.deepLinkOn = this.element.getAttribute('data-deep-link') == 'on';
                    // init accordion
                    this.initAccordion();
                };

                Accordion.prototype.initAccordion = function () {
                    //set initial aria attributes
                    for (var i = 0; i < this.items.length; i++) {
                        var button = this.items[i].getElementsByTagName('button')[0],
                                content = this.items[i].getElementsByClassName('js-accordion__panel')[0],
                                isOpen = this.items[i].classList.contains(this.showClass) ? 'true' : 'false';
                        button.setAttribute('aria-expanded', isOpen);
                        button.setAttribute('aria-controls', 'accordion-content-' + i);
                        button.setAttribute('id', 'accordion-header-' + i);
                        button.classList.add('js-accordion__trigger');
                        content.setAttribute('aria-labelledby', 'accordion-header-' + i);
                        content.setAttribute('id', 'accordion-content-' + i);
                    }

                    //listen for Accordion events
                    this.initAccordionEvents();

                    // check deep linking option
                    this.initDeepLink();
                };

                Accordion.prototype.initAccordionEvents = function () {
                    var self = this;

                    this.element.addEventListener('click', function (event) {
                        var trigger = event.target.closest('.js-accordion__trigger');
                        //check index to make sure the click didn't happen inside a children accordion
                        if (trigger && Array.prototype.indexOf.call(self.items, trigger.parentElement) >= 0)
                            self.triggerAccordion(trigger);
                    });
                };

                Accordion.prototype.triggerAccordion = function (trigger) {
                    var bool = (trigger.getAttribute('aria-expanded') === 'true');

                    this.animateAccordion(trigger, bool, false);

                    if (!bool && this.deepLinkOn) {
                        history.replaceState(null, '', '#' + trigger.getAttribute('aria-controls'));
                    }
                };

                Accordion.prototype.animateAccordion = function (trigger, bool, deepLink) {
                    var self = this;
                    var item = trigger.closest('.js-accordion__item'),
                            content = item.getElementsByClassName('js-accordion__panel')[0],
                            ariaValue = bool ? 'false' : 'true';

                    if (!bool)
                        item.classList.add(this.showClass);
                    trigger.setAttribute('aria-expanded', ariaValue);
                    self.resetContentVisibility(item, content, bool);

                    if (!this.multiItems && !bool || deepLink)
                        this.closeSiblings(item);
                };

                Accordion.prototype.resetContentVisibility = function (item, content, bool) {
                    item.classList.toggle(this.showClass, !bool);
                    content.removeAttribute("style");
                    if (bool && !this.multiItems) { // accordion item has been closed -> check if there's one open to move inside viewport 
                        this.moveContent();
                    }
                };

                Accordion.prototype.closeSiblings = function (item) {
                    //if only one accordion can be open -> search if there's another one open
                    var index = Array.prototype.indexOf.call(this.items, item);
                    for (var i = 0; i < this.items.length; i++) {
                        if (this.items[i].classList.contains(this.showClass) && i != index) {
                            this.animateAccordion(this.items[i].getElementsByClassName('js-accordion__trigger')[0], true, false);
                            return false;
                        }
                    }
                };

                Accordion.prototype.moveContent = function () { // make sure title of the accordion just opened is inside the viewport
                    var openAccordion = this.element.getElementsByClassName(this.showClass);
                    if (openAccordion.length == 0)
                        return;
                    var boundingRect = openAccordion[0].getBoundingClientRect();
                    if (boundingRect.top < 0 || boundingRect.top > window.innerHeight) {
                        var windowScrollTop = window.scrollY || document.documentElement.scrollTop;
                        window.scrollTo(0, boundingRect.top + windowScrollTop);
                    }
                };

                Accordion.prototype.initDeepLink = function () {
                    if (!this.deepLinkOn)
                        return;
                    var hash = window.location.hash.substr(1);
                    if (!hash || hash == '')
                        return;
                    var trigger = this.element.querySelector('.js-accordion__trigger[aria-controls="' + hash + '"]');
                    if (trigger && trigger.getAttribute('aria-expanded') !== 'true') {
                        this.animateAccordion(trigger, false, true);
                        setTimeout(function () {
                            trigger.scrollIntoView(true);
                        });
                    }
                };

                function getChildrenByClassName(el, className) {
                    var children = el.children,
                            childrenByClass = [];
                    for (var i = 0; i < children.length; i++) {
                        if (children[i].classList.contains(className))
                            childrenByClass.push(children[i]);
                    }
                    return childrenByClass;
                }
                ;

                window.Accordion = Accordion;

                //initialize the Accordion objects
                var accordions = document.getElementsByClassName('js-accordion');
                if (accordions.length > 0) {
                    for (var i = 0; i < accordions.length; i++) {
                        (function (i) {
                            new Accordion(accordions[i]);
                        })(i);
                    }
                }
            }());
        </script>
        <script>
          

// File#: _1_modal-window
// Usage: codyhouse.co/license
            (function () {
                var Modal = function (element) {
                    this.element = element;
                    this.triggers = document.querySelectorAll('[aria-controls="' + this.element.getAttribute('id') + '"]');
                    this.firstFocusable = null;
                    this.lastFocusable = null;
                    this.moveFocusEl = null; // focus will be moved to this element when modal is open
                    this.modalFocus = this.element.getAttribute('data-modal-first-focus') ? this.element.querySelector(this.element.getAttribute('data-modal-first-focus')) : null;
                    this.selectedTrigger = null;
                    this.preventScrollEl = this.getPreventScrollEl();
                    this.showClass = "modal--is-visible";
                    this.initModal();
                };

                Modal.prototype.getPreventScrollEl = function () {
                    var scrollEl = false;
                    var querySelector = this.element.getAttribute('data-modal-prevent-scroll');
                    if (querySelector)
                        scrollEl = document.querySelector(querySelector);
                    return scrollEl;
                };

                Modal.prototype.initModal = function () {
                    var self = this;
                    //open modal when clicking on trigger buttons
                    if (this.triggers) {
                        for (var i = 0; i < this.triggers.length; i++) {
                            this.triggers[i].addEventListener('click', function (event) {
                                event.preventDefault();
                                if (Util.hasClass(self.element, self.showClass)) {
                                    self.closeModal();
                                    return;
                                }
                                self.selectedTrigger = event.currentTarget;
                                self.showModal();
                                self.initModalEvents();
                            });
                        }
                    }

                    // listen to the openModal event -> open modal without a trigger button
                    this.element.addEventListener('openModal', function (event) {
                        if (event.detail)
                            self.selectedTrigger = event.detail;
                        self.showModal();
                        self.initModalEvents();
                    });

                    // listen to the closeModal event -> close modal without a trigger button
                    this.element.addEventListener('closeModal', function (event) {
                        if (event.detail)
                            self.selectedTrigger = event.detail;
                        self.closeModal();
                    });

                    // if modal is open by default -> initialise modal events
                    if (Util.hasClass(this.element, this.showClass))
                        this.initModalEvents();
                };

                Modal.prototype.showModal = function () {
                    var self = this;
                    Util.addClass(this.element, this.showClass);
                    this.getFocusableElements();
                    if (this.moveFocusEl) {
                        this.moveFocusEl.focus();
                        // wait for the end of transitions before moving focus
                        this.element.addEventListener("transitionend", function cb(event) {
                            self.moveFocusEl.focus();
                            self.element.removeEventListener("transitionend", cb);
                        });
                    }
                    this.emitModalEvents('modalIsOpen');
                    // change the overflow of the preventScrollEl
                    if (this.preventScrollEl)
                        this.preventScrollEl.style.overflow = 'hidden';
                };

                Modal.prototype.closeModal = function () {
                    if (!Util.hasClass(this.element, this.showClass))
                        return;
                    Util.removeClass(this.element, this.showClass);
                    this.firstFocusable = null;
                    this.lastFocusable = null;
                    this.moveFocusEl = null;
                    if (this.selectedTrigger)
                        this.selectedTrigger.focus();
                    //remove listeners
                    this.cancelModalEvents();
                    this.emitModalEvents('modalIsClose');
                    // change the overflow of the preventScrollEl
                    if (this.preventScrollEl)
                        this.preventScrollEl.style.overflow = '';
                };

                Modal.prototype.initModalEvents = function () {
                    //add event listeners
                    this.element.addEventListener('keydown', this);
                    this.element.addEventListener('click', this);
                };

                Modal.prototype.cancelModalEvents = function () {
                    //remove event listeners
                    this.element.removeEventListener('keydown', this);
                    this.element.removeEventListener('click', this);
                };

                Modal.prototype.handleEvent = function (event) {
                    switch (event.type) {
                        case 'click':
                        {
                            this.initClick(event);
                        }
                        case 'keydown':
                        {
                            this.initKeyDown(event);
                        }
                    }
                };

                Modal.prototype.initKeyDown = function (event) {
                    if (event.keyCode && event.keyCode == 9 || event.key && event.key == 'Tab') {
                        //trap focus inside modal
                        this.trapFocus(event);
                    } else if ((event.keyCode && event.keyCode == 13 || event.key && event.key == 'Enter') && event.target.closest('.js-modal__close')) {
                        event.preventDefault();
                        this.closeModal(); // close modal when pressing Enter on close button
                    }
                };

                Modal.prototype.initClick = function (event) {
                    //close modal when clicking on close button or modal bg layer 
                    if (!event.target.closest('.js-modal__close') && !Util.hasClass(event.target, 'js-modal'))
                        return;
                    event.preventDefault();
                    this.closeModal();
                };

                Modal.prototype.trapFocus = function (event) {
                    if (this.firstFocusable == document.activeElement && event.shiftKey) {
                        //on Shift+Tab -> focus last focusable element when focus moves out of modal
                        event.preventDefault();
                        this.lastFocusable.focus();
                    }
                    if (this.lastFocusable == document.activeElement && !event.shiftKey) {
                        //on Tab -> focus first focusable element when focus moves out of modal
                        event.preventDefault();
                        this.firstFocusable.focus();
                    }
                }

                Modal.prototype.getFocusableElements = function () {
                    //get all focusable elements inside the modal
                    var allFocusable = this.element.querySelectorAll(focusableElString);
                    this.getFirstVisible(allFocusable);
                    this.getLastVisible(allFocusable);
                    this.getFirstFocusable();
                };

                Modal.prototype.getFirstVisible = function (elements) {
                    //get first visible focusable element inside the modal
                    for (var i = 0; i < elements.length; i++) {
                        if (isVisible(elements[i])) {
                            this.firstFocusable = elements[i];
                            break;
                        }
                    }
                };

                Modal.prototype.getLastVisible = function (elements) {
                    //get last visible focusable element inside the modal
                    for (var i = elements.length - 1; i >= 0; i--) {
                        if (isVisible(elements[i])) {
                            this.lastFocusable = elements[i];
                            break;
                        }
                    }
                };

                Modal.prototype.getFirstFocusable = function () {
                    if (!this.modalFocus || !Element.prototype.matches) {
                        this.moveFocusEl = this.firstFocusable;
                        return;
                    }
                    var containerIsFocusable = this.modalFocus.matches(focusableElString);
                    if (containerIsFocusable) {
                        this.moveFocusEl = this.modalFocus;
                    } else {
                        this.moveFocusEl = false;
                        var elements = this.modalFocus.querySelectorAll(focusableElString);
                        for (var i = 0; i < elements.length; i++) {
                            if (isVisible(elements[i])) {
                                this.moveFocusEl = elements[i];
                                break;
                            }
                        }
                        if (!this.moveFocusEl)
                            this.moveFocusEl = this.firstFocusable;
                    }
                };

                Modal.prototype.emitModalEvents = function (eventName) {
                    var event = new CustomEvent(eventName, {detail: this.selectedTrigger});
                    this.element.dispatchEvent(event);
                };

                function isVisible(element) {
                    return element.offsetWidth || element.offsetHeight || element.getClientRects().length;
                }
                ;

                window.Modal = Modal;

                //initialize the Modal objects
                var modals = document.getElementsByClassName('js-modal');
                // generic focusable elements string selector
                var focusableElString = '[href], input:not([disabled]), select:not([disabled]), textarea:not([disabled]), button:not([disabled]), iframe, object, embed, [tabindex]:not([tabindex="-1"]), [contenteditable], audio[controls], video[controls], summary';
                if (modals.length > 0) {
                    var modalArrays = [];
                    for (var i = 0; i < modals.length; i++) {
                        (function (i) {
                            modalArrays.push(new Modal(modals[i]));
                        })(i);
                    }

                    window.addEventListener('keydown', function (event) { //close modal window on esc
                        if (event.keyCode && event.keyCode == 27 || event.key && event.key.toLowerCase() == 'escape') {
                            for (var i = 0; i < modalArrays.length; i++) {
                                (function (i) {
                                    modalArrays[i].closeModal();
                                })(i);
                            }
                            ;
                        }
                    });
                }
            }());
        </script>
    </body> 
</html>
