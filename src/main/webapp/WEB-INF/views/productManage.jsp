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

    <title>MSXT - ��Ʒ����</title>

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

    <!-- ADD CSS HERE! -->
    <style type="text/css">
        @import url("<c:url value="/resources/css/landing-page.min.css" />");
        @import url("<c:url value="/resources/css/manage-page.css" />");
    </style>


</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-light bg-light static-top">
    <div class="container">
        <a class="navbar-brand" href="<c:url value="/main/list.html" />">MSXT</a>
    </div>
</nav>



<!-- Icons Grid -->
<section class="features-icons bg-light">
    <div class="container">
        <div class="row col-md-13 col-md-offset-2 custyle">
            <table class="table table-striped custab">
                <thead>
                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#product_add"><i class="fa fa-plus"></i> �����Ʒ</button>
                <tr>
                    <th>��Ʒ��</th>
                    <th>ͼƬ</th>
                    <th>��Ʒ��</th>
                    <th>��Ʒ���</th>
                    <th>��ɱ��ʼ/����</th>
                    <th>ԭ��</th>
                    <th>�ۿۼ�</th>
                    <th>�����</th>
                    <th class="text-center">����</th>
                </tr>
                </thead>

                <c:forEach items="${allProduct.key}" var="productInfo" >
                    <tr>
                        <td><c:out value="${productInfo.productId}"/></td>
                        <td>
                            <div class="product-image4">
                                <a href="#">
                                    <img class="pic-1" src="<c:out value="${productInfo.photo}"/>">
                                </a>
                            </div>
                        </td>
                        <td><c:out value="${productInfo.productName}"/></td>
                        <td><c:out value="${productInfo.description}"/></td>
                        <td><c:out value="${productInfo.startTime}"/><br/><c:out value="${productInfo.endTime}"/></td>
                        <td><c:out value="${productInfo.price}"/></td>
                        <td><c:out value="${productInfo.priceSpike}"/></td>
                        <td><c:out value="${productInfo.stock}"/></td>
                        <td class="text-center">
                            <button class='btn btn-info btn-xs' data-toggle="modal" data-target="#product_fix" data-url="<c:out value="${productInfo.photo}"/>" data-name="<c:out value="${productInfo.productName}"/>" data-description="<c:out value="${productInfo.description}"/>" data-ori="<c:out value="${productInfo.price}"/>" data-sale="<c:out value="${productInfo.priceSpike}"/>" data-stock="<c:out value="${productInfo.stock}"/>" >
                                <span class="glyphicon glyphicon-edit"></span>
                                �޸�
                            </button>
                            <button class="btn btn-danger btn-xs" onClick="location.href='/mxst/product/list/delete.html?productId=<c:out value="${productInfo.productId}"/>'" type="submit" formmethod="post">
                                <span class="glyphicon glyphicon-remove"></span>
                                ɾ��
                            </button>
                        </td>
                    </tr>
                </c:forEach>

            </table>
        </div>
    </div>

    <div class="modal fade" id="product_add">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <a href="#" data-dismiss="modal" class="class pull-right"><span class="glyphicon glyphicon-remove"></span></a>
                    <h3 class="modal-title">�������Ʒ</h3>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 product_content">
                        <sf:form method="POST" action="/mxst/product/list/add.html" commandName="product">
                            <table class="table table-striped custab">
                                <thead>
                                <tr>
                                    <th> </th>
                                    <th>��������Ʒ��������Ϣ</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>
                                        ͼƬ��URL��
                                    </td>
                                    <td>
                                        <input type="text"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��Ʒ��
                                    </td>
                                    <td>
                                        <input type="text"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��Ʒ���
                                    </td>
                                    <td>
                                        <textarea name="content" cols="40" rows="8" ></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��ɱ��ʼ
                                    </td>
                                    <td>
                                        <input type="date"/>
                                        <input type="time"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��ɱ����
                                    </td>
                                    <td>
                                        <input type="date"/>
                                        <input type="time"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ԭ��
                                    </td>
                                    <td>
                                        <input type="number" min=0/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        �ۿۼ�
                                    </td>
                                    <td>
                                        <input type="number" min=0/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        �����
                                    </td>
                                    <td>
                                        <input type="number" min=0/>
                                    </td>
                                </tr>
                            </table>
                        </sf:form>
                        </div>
                        <div class="col-md-12 text-center">
                            <button class='btn btn-info btn-xs' href="#" style="background:#007bff">
                                <span class="glyphicon glyphicon-edit"></span>
                                ���
                            </button>
                            <button data-dismiss="modal" class="btn btn-danger btn-xs">
                                <span class="glyphicon glyphicon-remove"></span>
                                ȡ��
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="product_fix">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <a href="#" data-dismiss="modal" class="class pull-right"><span class="glyphicon glyphicon-remove"></span></a>
                    <h3 class="modal-title">�޸���Ʒ��Ϣ</h3>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12 product_content">
                            <table class="table table-striped custab">
                                <thead>
                                <tr>
                                    <th> </th>
                                    <th>��������Ʒ��������Ϣ</th>
                                </tr>
                                </thead>
                                <tr>
                                    <td>
                                        ͼƬ��URL��
                                    </td>
                                    <td>
                                        <input type="text" id="photo" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��Ʒ��
                                    </td>
                                    <td>
                                        <input type="text" id="product_name" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��Ʒ���
                                    </td>
                                    <td>
                                        <textarea name="content" cols="40" rows="8" id="description" value=""></textarea>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��ɱ��ʼ
                                    </td>
                                    <td>
                                        <input type="date"/>
                                        <input type="time"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ��ɱ����
                                    </td>
                                    <td>
                                        <input type="date"/>
                                        <input type="time"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        ԭ��
                                    </td>
                                    <td>
                                        <input type="number" min=0 id="price_original" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        �ۿۼ�
                                    </td>
                                    <td>
                                        <input type="number" min=0 id="price_sale" value=""/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        �����
                                    </td>
                                    <td>
                                        <input type="number" min=0 id="stock" value=""/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="col-md-12 text-center">
                            <button class='btn btn-info btn-xs' href="#">
                                <span class="glyphicon glyphicon-edit"></span>
                                �޸�
                            </button>
                            <button data-dismiss="modal" class="btn btn-danger btn-xs">
                                <span class="glyphicon glyphicon-remove"></span>
                                ȡ��
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
                <p class="text-muted small mb-4 mb-lg-0">&copy; ��2020�ƶ�������������̡� ����־�����μ���   All Rights Reserved.</p>
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
<script type="text/javascript" src="<c:url value="/resources/vendor/jquery/jquery.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.bundle.min.js"/>"></script>
<script>
    $('#product_fix').on('show.bs.modal', function (event) {
        var button = $(event.relatedTarget) // Button that triggered the modal
        var photo = button.data('url') // Extract info from data-* attributes
        var product_name = button.data('name')
        var description = button.data('description')
        var price_original = button.data('ori')
        var price_sale = button.data('sale')
        var stock = button.data('stock')
        // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        var modal = $(this)
        modal.find('.modal-body #photo').val(photo)
        modal.find('.modal-body #product_name').val(product_name)
        modal.find('.modal-body #description').val(description)
        modal.find('.modal-body #price_original').val(price_original)
        modal.find('.modal-body #price_sale').val(price_sale)
        modal.find('.modal-body #stock').val(stock)
    })
</script>

</body>

</html>
