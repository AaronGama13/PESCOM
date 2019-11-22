<%-- 
    Document   : menu
    Created on : 19/11/2019, 11:34:21 PM
    Author     : pinit
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="CSS/universal.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
    </head>
    <body>
    <center>
        <header>
            <div>
                <a href="productos.jsp">LINIO MX</a>
                <a href="index.jsp"><img class='view_cart' src="IMG/user.jpg" width="30" height="30"></a>
            </div>
        </header>
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <ol class="carousel-indicators">
                <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                <li data-target="#myCarousel" data-slide-to="1"></li>
                <li data-target="#myCarousel" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
                <div class="item active">
                    <img src="IMG/img1.jpg" alt="">
                </div>
                <div class="item">
                    <img src="IMG/img2.jpg" alt="">
                </div>
                <div class="item">
                    <img src="IMG/img3.jpeg" alt="">
                </div>
            </div>    
            
            <a class="left carousel-control" href="#myCarousel" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-right"></span>
                <span class="sr-only">Anterior</span>
            </a>
            
             <a class="right carousel-control" href="#myCarousel" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right"></span>
                <span class="sr-only">Siguiente</span>
            </a>            
        </div>
        
        <script type="text/javascript">
        
            $('#myCarouselCustom').carousel();
            $("#prevBtn").click(function(){
            $("#myCarouselCustom").carousel("prev");
            });
            
            $("#nextBtn").click(function(){
            $("#myCarouselCustom").carousel("next");
            });
        </script>
        <script type="text/javascript">
        $('.carousel').carousel({
            interval: 8000,
            pause:true,
            wrap:false
        });
        </script>
        <div>
            LINIO MX es un sitio web diseñado para faciliar la compraventa
        </div>
    </center>
    </body>
</html>
