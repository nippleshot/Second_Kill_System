<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>

<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>MSXT - 订单</title>

    <!-- Bootstrap core CSS -->
    <style type="text/css">
        @import url("<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css" />");
    </style>

    <!-- Custom fonts for this template -->
    <style type="text/css">
        @import url("<c:url value="/resources/vendor/fontawesome-free/css/all.min.css" />");
        @import url("<c:url value="/resources/vendor/simple-line-icons/css/simple-line-icons.css" />");
    </style>
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">
    <link href="http://cdn.shopify.com/s/files/1/0067/5617/1846/t/2/assets/timber.scss.css" rel="stylesheet" type="text/css" media="all" />
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.3/css/all.css" integrity="sha384-UHRtZLI+pbxtHCWp1t77Bi1L4ZtiqrqD80Kn4Z8NTSRyMA2Fd33n5dQ8lWUE00s/" crossorigin="anonymous">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.0/animate.css" rel="stylesheet" type="text/css" media="all" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.css" rel="stylesheet" type="text/css"/>
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ=" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/elevatezoom/3.0.8/jquery.elevatezoom.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.js"></script>

    <!-- ADD CSS HERE! -->
    <style type="text/css">
        @import url("<c:url value="/resources/css/landing-page.min.css" />");
        @import url("<c:url value="/resources/css/order-page.css" />");
    </style>

</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-light bg-light static-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value="/main/list/user.html?userId=${userId}&userName=${userName}&userBalance=${userBalance}" />">MSXT</a>
        <div class="dropdown">
            <button class="btn btn-primary dropdown-toggle" data-toggle="dropdown">
                <c:out value="${userName}"/>
            </button>
            <div class="dropdown-menu">
                <a class="dropdown-item">我的余额 ： <c:out value="${userBalance}"/> </a>
                <a class="dropdown-item" href="/mxst/user/charge.html?userId=${userId}">充值金额</a>
                <a class="dropdown-item" href="<c:url value="/main/list.html" />">退出</a>
            </div>
        </div>
    </div>
</nav>



<!-- Icons Grid -->
<section class="features-icons bg-light">
    <div class="wrapper">

        <main>
            <div id="shopify-section-product-template" class="shopify-section">
                <div class="single-product-area mt-80 mb-80">
                    <div class="container">
                        <div class="row">
                            <!--Picture Area-->
                            <div class="col-md-6">
                                <div class="product-details-large" id="ProductPhoto">
                                    <img id="ProductPhotoImg" class="product-zoom" data-image-id="" alt="12. Aliexpress dropshipping by oberlo" data-zoom-image="${photo}" src="${photo}">
                                </div>


                            </div>
                            <!--Order Area-->
                            <div class="col-md-6">
                                <div class="single-product-content">
                                        <sf:form method="post" commandName="order" id="AddToCartForm" class="shopify-product-form" action="/mxst/order.html?userId=${userId}">
                                            <sf:input path="productId" type="hidden" value="${productId}"/>
                                            <div class="product-details">
                                            <h1 class="single-product-name">${productName}</h1>
                                            <div class="product-sku">商品号: <span class="variant-sku">${productId}</span></div>
                                            <div class="single-product-price">
                                                <div class="price">
                                                    <input hidden="true" id="product-sale-price" value="${priceSpike}"/>
                                                    ${priceSpike}元
                                                    <span>${price}元</span>
                                                </div>

                                            </div>
                                            <div class="product-info">${description}</div>

                                            <div class="single-product-action">

                                                <div class="product-add-to-cart">
                                                    <span class="control-label">数量</span>
                                                    <div class="cart-plus-minus" style="float:left;">
                                                        <sf:input path="num" class="cart-plus-minus-box" id="quantity" type="number" min="0" value="0" readonly="true" required="required"/>
                                                    </div>
                                                    <div>
                                                        <input type="button" value="+" style="background:#708090;color:white" onclick="cal_add()"/>
                                                        <input type="button" value=" - "style="background:#708090;color:white" onclick="cal_sub()"/>
                                                    </div>
                                                    <br/>

                                                    <span class="control-label">收货地址</span>
                                                    <div class="cart-plus-minus">
                                                        <sf:input path="address" class="address-box" type="text" style="width=200px;" required="required"/>
                                                    </div>
                                                    <br/>

                                                    <span class="control-label">收货人电话号码</span>
                                                    <div class="cart-plus-minus">
                                                        <sf:input path="telephoneNumber" class="telephone-box" type="number" required="required"/>
                                                    </div>
                                                    <br/>

                                                    <span class="control-label">收货人姓名</span>
                                                    <div class="cart-plus-minus">
                                                        <sf:input path="consignee" class="name-box" type="text" required="required"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="single-product-price">
                                                <div class="single-product-price row">
                                                    <div class="price col-xs-4" style="font-size:20px;font-weight:400;margin-left:15px">
                                                        实付款 ： <sf:input path="totalPrice" type="number" id="total-price" value="0.00" style="width:150px;color:#007bff" readonly="true"/>
                                                    </div>

                                                    <div class="col-xs-4" style="color:#f06666;margin-left:20px"> 剩下时间 </br> <span style="font-size:25px;font-weight:500" id="countdown">23:23:20</span> </div>
                                                </div>


                                                <div class="add">
                                                    <button type="submit" class="add-to-cart ajax-spin-cart" id="AddToCart" style="width:150px">
                                                        <span class="list-cart-title cart-title" id="AddToCartText">确定</span>
                                                    </button>

                                                </div>

                                            </div>

                                        </div>
                                        </sf:form>

                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <style type="text/css">.product-details .countdown-timer-wrapper{display: none !important;}</style>

                <script>
                    function cal_add(){
                        var sale_price_val = parseFloat(document.getElementById('product-sale-price').value);
                        var input_quantity = document.getElementById('quantity');
                        var input_quantity_val = parseInt(input_quantity.value);
                        var input_total_price = document.getElementById('total-price');
                        var input_total_price_val = parseFloat(input_total_price.value);

                        input_quantity.value = input_quantity_val+1;
                        input_total_price.value = parseFloat(input_total_price_val+sale_price_val).toFixed(2);
                    }

                    function cal_sub(){
                        var sale_price_val = parseFloat(document.getElementById('product-sale-price').value);
                        var input_quantity = document.getElementById('quantity');
                        var input_quantity_val = parseInt(input_quantity.value);
                        if(input_quantity_val==0){
                            alert("数量已经是零");
                            return null;
                        }
                        var input_total_price = document.getElementById('total-price');
                        var input_total_price_val = parseFloat(input_total_price.value);

                        input_quantity.value = input_quantity_val-1;
                        input_total_price.value = parseFloat(input_total_price_val-sale_price_val).toFixed(2);
                    }
                </script>

                <script>
                    function productZoom(){
                        $(".product-zoom").elevateZoom({
                            gallery: 'ProductThumbs',
                            galleryActiveClass: "active",
                            zoomType: "inner",
                            cursor: "crosshair"
                        });$(".product-zoom").on("click", function(e) {
                            var ez = $('.product-zoom').data('elevateZoom');
                            $.fancybox(ez.getGalleryList());
                            return false;
                        });

                    };
                    function productZoomDisable(){
                        if( $(window).width() < 767 ) {
                            $('.zoomContainer').remove();
                            $(".product-zoom").removeData('elevateZoom');
                            $(".product-zoom").removeData('zoomImage');
                        } else {
                            productZoom();
                        }
                    };

                    productZoomDisable();

                    $(window).resize(function() {
                        productZoomDisable();
                    });
                </script>
                <script>
                    $('.product-thumbnail').owlCarousel({
                        loop: true,
                        center: true,
                        nav: true,dots:false,
                        margin:10,
                        autoplay: false,
                        autoplayTimeout: 5000,
                        navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>'],
                        item: 3,
                        responsive: {
                            0: {
                                items: 2
                            },
                            480: {
                                items: 3
                            },
                            992: {
                                items: 3,
                            },
                            1170: {
                                items: 3,
                            },
                            1200: {
                                items: 3
                            }
                        }
                    });
                </script>
            </div>
        </main>

    </div>
</section>

<!-- Footer -->
<footer class="footer bg-light">
    <div class="container">
        <div class="row">
            <div class="col-lg-6 h-100 text-center text-lg-left my-auto">
                <ul class="list-inline mb-2">
                    <li class="list-inline-item">
                        <a href="#">About</a>
                    </li>
                    <li class="list-inline-item">&sdot;</li>
                    <li class="list-inline-item">
                        <a href="#">Contact</a>
                    </li>
                    <li class="list-inline-item">&sdot;</li>
                    <li class="list-inline-item">
                        <a href="#">Terms of Use</a>
                    </li>
                    <li class="list-inline-item">&sdot;</li>
                    <li class="list-inline-item">
                        <a href="#">Privacy Policy</a>
                    </li>
                </ul>
                <p class="text-muted small mb-4 mb-lg-0">&copy; 【2020移动互联网软件工程】 ：徐志威，宋吉载   All Rights Reserved.</p>
            </div>
            <div class="col-lg-6 h-100 text-center text-lg-right my-auto">
                <ul class="list-inline mb-0">
                    <li class="list-inline-item mr-3">
                        <a href="#">
                            <i class="fab fa-facebook fa-2x fa-fw"></i>
                        </a>
                    </li>
                    <li class="list-inline-item mr-3">
                        <a href="#">
                            <i class="fab fa-twitter-square fa-2x fa-fw"></i>
                        </a>
                    </li>
                    <li class="list-inline-item">
                        <a href="#">
                            <i class="fab fa-instagram fa-2x fa-fw"></i>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="../vendor/jquery/jquery.min.js"></script>
<script src="../vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>