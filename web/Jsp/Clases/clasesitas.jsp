<%@page import="Conexion.BD"%>
<%@page import="java.sql.ResultSet"%>
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
    BD basesita = new BD();
    basesita.conectar();

    String UsuarioInfo = "Select * from Usuario where id_usu = '" + idPersona + "'"; //selecionamos los datos del maestro de la tabla Docente
    ResultSet rsDatosPer = basesita.consulta(UsuarioInfo);
    if (rsDatosPer.next()) {
        correo = rsDatosPer.getString(3);
%>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../../CSS/CSS_foro/clasesitas.css" rel="stylesheet" type="text/css" />
        <link rel="shorcut icon" href="../Img/logos/LogoNexTech.png">
        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins&display=swap');
        </style>
    </head>

    <body>
        <section class="hero">
            <div class="cd-container cd-max-width-adaptive-sm">
                <div class="hero__label cd-margin-bottom-2xs"><%=rsDatosPer.getString(2)%></div>

                <h1 class="cd-margin-bottom-xs">Tus clases</h1>

                <p class="cd-line-height-lg cd-margin-bottom-sm">Bienvenido profesor! Aquí podrás visualizar tus 
                    clases creadas y consultar las calificaciones de tus alumnos.
                </p>

                <div class="hero__cta">
                    <button class="learn-more">
                        <span class="circle" aria-hidden="true">
                            <span class="icon arrow"></span>
                        </span>
                        <span class="button-text"><a href="CrearClaseForm.html">Crear clase</a></span>
                    </button>
                    <a href="#0" class="cd-link cd-link--contrast-higher">Learn more</a>
                </div>
            </div>
        </section>

        <section class="tableClases">
            <table class="table table--expanded@sm tv5-position-relative tv5-z-index-1 tv5-width-100% tv5-text-sm js-table"
                   aria-label="Table Example">
                <thead class="table__header table__header--sticky">
                    <tr class="table__row">
                        <th class="table__cell tv5-text-left" scope="col">Nombre</th>
                        <th class="table__cell tv5-text-left" scope="col">Grado de la clase</th>
                        <th class="table__cell tv5-text-left" scope="col">Color</th>
                        <th class="table__cell tv5-text-left" scope="col">Clave</th>
                        <th class="table__cell tv5-text-left" scope="col">Ver listas</th>
                    </tr>
                </thead>

                <tbody class="table__body">
                    <%
                        try {
                            String strQry = "select * from Clases where id_usu = '" + idPersona + "'";
                            ResultSet rs = null;
                            rs = basesita.consulta(strQry);
                            int id_clase;
                            while (rs.next()) {
                                id_clase = Integer.parseInt(rs.getString(2));
                    %>
                    <tr class="table__row">
                        <td class="table__cell" role="cell">
                            <span class="table__label" aria-hidden="true">Nombre</span> <%=rs.getString(2)%>
                        </td>

                        <td class="table__cell" role="cell">
                            <span class="table__label" aria-hidden="true">Grado de la clase</span> <%=rs.getString(3)%>
                        </td>

                        <td class="table__cell tv5-text-center" role="cell">
                            <span class="table__label" aria-hidden="true">Color</span>
                            <svg class="tv5-icon tv5-icon--md" viewBox="0 0 48 48">
                            <title>Option available</title>
                            <path d="M24,47A23,23,0,1,1,47,24,23.026,23.026,0,0,1,24,47Z" fill="#87c458" />
                            <polyline points="12 24 20 32 36 16" fill="none" stroke="#fff" stroke-linecap="square"
                                      stroke-miterlimit="10" stroke-width="4" />
                            </svg>
                        </td>
                        <td class="table__cell tv5-ws-nowrap" role="cell">
                            <span class="table__label" aria-hidden="true">Clave</span><%=rs.getString(4)%>
                        </td>

                        <td class="table__cell" role="cell">
                            <span class="table__label" aria-hidden="true">Ver listas</span>
                            <button class="tv5-btn tv5-btn--subtle"><a href="">Ver listas</a></button>
                        </td>
                    </tr>
                    <%
                                }
                                rs.close();
                                basesita.cierraConexion();
                            } catch (Exception ex) {
                                out.print(ex.getMessage());
                            }
                        
                    %>

                    <tr class="table__row">
                        <td class="table__cell" role="cell">
                            <span class="table__label" aria-hidden="true">Name:</span> Joshua
                        </td>

                        <td class="table__cell" role="cell">
                            <span class="table__label" aria-hidden="true">Description:</span> Lorem ipsum, dolor sit amet
                            consectetur adipisicing elit. Laboriosam libero recusandae corrupti?
                        </td>

                        <td class="table__cell tv5-text-center" role="cell">
                            <span class="table__label" aria-hidden="true">Option:</span>
                            <svg class="tv5-icon tv5-icon--md" viewBox="0 0 48 48">
                            <title>Option available</title>
                            <path d="M24,47A23,23,0,1,1,47,24,23.026,23.026,0,0,1,24,47Z" fill="#87c458" />
                            <polyline points="12 24 20 32 36 16" fill="none" stroke="#fff" stroke-linecap="square"
                                      stroke-miterlimit="10" stroke-width="4" />
                            </svg>
                        </td>

                        <td class="table__cell" role="cell">
                            <span class="table__label" aria-hidden="true">Date:</span> 18 Nojuyhtgr
                        </td>

                        <td class="table__cell" role="cell">
                            <span class="table__label" aria-hidden="true">Action:</span>
                            <button class="tv5-btn tv5-btn--subtle">Button</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>


<%
            }
        %>
    </body>
    <script>
        // utility functions
        if (!Util) function Util() {
        }
        ;

        Util.addClass = function (el, className) {
            var classList = className.split(' ');
            el.classList.add(classList[0]);
            if (classList.length > 1)
                Util.addClass(el, classList.slice(1).join(' '));
        };

        Util.removeClass = function (el, className) {
            var classList = className.split(' ');
            el.classList.remove(classList[0]);
            if (classList.length > 1)
                Util.removeClass(el, classList.slice(1).join(' '));
        };

        Util.toggleClass = function (el, className, bool) {
            if (bool)
                Util.addClass(el, className);
            else
                Util.removeClass(el, className);
        };

        // File#: _1_table
        // Usage: codyhouse.co/license
        (function () {
            function initTable(table) {
                checkTableLayour(table); // switch from a collapsed to an expanded layout
                Util.addClass(table, 'table--loaded'); // show table

                // custom event emitted when window is resized
                table.addEventListener('update-table', function (event) {
                    checkTableLayour(table);
                });
            }
            ;

            function checkTableLayour(table) {
                var layout = getComputedStyle(table, ':before').getPropertyValue('content').replace(/\'|"/g, '');
                Util.toggleClass(table, tableExpandedLayoutClass, layout != 'collapsed');
            }
            ;

            var tables = document.getElementsByClassName('js-table'),
                    tableExpandedLayoutClass = 'table--expanded';
            if (tables.length > 0) {
                var j = 0;
                for (var i = 0; i < tables.length; i++) {
                    var beforeContent = getComputedStyle(tables[i], ':before').getPropertyValue('content');
                    if (beforeContent && beforeContent != '' && beforeContent != 'none') {
                        (function (i) {
                            initTable(tables[i]);
                        })(i);
                        j = j + 1;
                    } else {
                        Util.addClass(tables[i], 'table--loaded');
                    }
                }

                if (j > 0) {
                    var resizingId = false,
                            customEvent = new CustomEvent('update-table');
                    window.addEventListener('resize', function (event) {
                        clearTimeout(resizingId);
                        resizingId = setTimeout(doneResizing, 300);
                    });

                    function doneResizing() {
                        for (var i = 0; i < tables.length; i++) {
                            (function (i) {
                                tables[i].dispatchEvent(customEvent)
                            })(i);
                        }
                        ;
                    }
                    ;

                    (window.requestAnimationFrame) // init table layout
                            ? window.requestAnimationFrame(doneResizing)
                            : doneResizing();
                }
            }
        }());
    </script>

</html>