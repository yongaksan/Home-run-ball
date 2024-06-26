<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
        <%@include file="/resources/css/adminMenu.css" %>
        <%@include file="/resources/css/adminDefaultTable.css" %>
        .productExposureManage-container {
            width: 100%;
            margin: 20px 0px;
            display: inline-block;
            text-align: center;
        }

        .productExposureManage-container td {
            text-align: left;
            padding-left: 20px;
        }
        strong {
            font-weight: bold;
            color: #1b64da;
        }

        textarea {
            width: 100%;
            height: 200px;
        }

        .buttons {
            margin: 20px;
            text-align: center;
        }

        .registerBtn, .cancelBtn {
            padding: 10px;
            font-size: 13px;
            border-radius: 4px;
            border: 1px solid #000000;
            cursor: pointer;
        }
        .registerBtn {
            color: white;
            background-color: #585858;
        }

        .cancelBtn {
            color: #000000;
            background-color: white;
        }

        .cancelBtn:hover {
            background: #0b7dda;
            color: white;
        }

        .registerBtn:hover {
            background: #0b7dda;
        }
    </style>
    <title>ProductExposure</title>
    <% String msg = (String) request.getAttribute("msg"); %>
    <% if (msg != null && !msg.isEmpty()) { %>
    <script>
        alert("<%= msg %>");
    </script>
    <% } %>
</head>
<body>
<jsp:include page="../../adminMenu.jsp" flush="false"/>
<div id="main">
    <div class="w3-dark-grey header-container">
        <div class="w3-dark-grey header-button">
            <button id="openNav" class="w3-button w3-dark-grey w3-xlarge" onclick="w3_open()">&#9776;</button>
            <button id="closeNav" class="w3-button w3-dark-grey w3-xlarge" onclick="w3_close()" style="display:none">&times;</button>
        </div>
        <div id="headline" class="header-title">표시설정 일괄변경</div>
    </div>

    <div class="w3-container productExposureManage-container">
        <form id="registerForm" action="<c:url value='/admin/product/manage'/>" method="post">
        <div class="product_content">
            <table>
                <tr>
                    <td colspan="3">
                        총 <strong>${selectedProductCount}</strong>개 제품의 표시설정을 일괄 변경합니다.
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <input type="checkbox" id="selectAll">
                        <label for="selectAll">전체 선택</label>
                    </td>
                </tr>
                <tr>
                    <th style="width:50px;">
                        <input type="checkbox" name="selectedContent" id="productShow" value="pd_is_show">
                    </th>
                    <th style="width: 200px;">
                        <label for="productShow">진열 상태</label>
                    </th>
                    <td>
                        <input type='radio' id="onShow" name='pd_is_show' value='Y' />
                        <label for="onShow">진열하기</label>
                        <input type='radio' id="noShow" name='pd_is_show' value='N' />
                        <label for="noShow">진열제외</label>
                    </td>
                </tr>
                <tr>
                    <th style="width:50px;">
                        <input type="checkbox" name="selectedContent" id="productStatus" value="pd_stat_hist_cd">
                    </th>
                    <th style="width: 200px;">
                        <label for="productStatus">판매 상태</label>
                    </th>
                    <td>
                        <input type='radio' id="planSale" name='pd_stat_hist_cd' value='planSale' />
                        <label for="planSale">판매 예정</label>
                        <input type='radio' id="onSale" name='pd_stat_hist_cd' value='onSale' />
                        <label for="onSale">판매 중</label>
                        <input type='radio' id="notSale" name='pd_stat_hist_cd' value='notSale' />
                        <label for="notSale">판매 안 함</label>
                    </td>
                </tr>
                <tr>
                    <th style="width: 50px;">
                        <input type="checkbox" name="selectedContent" id="productCharacter" value="pd_chr_cd">
                    </th>
                    <th style="width: 200px;">
                        <label for="productCharacter">제품 특성</label>
                    </th>
                    <td>
                        <input type="checkbox" id="npd" name="pd_chr_cd" value="N">
                        <label for="npd">신상품</label><br>
                        <input type="checkbox" id="hpd" name="pd_chr_cd" value="H">
                        <label for="hpd">인기 제품</label><br>
                        <input type="checkbox" id="spd" name="pd_chr_cd" value="S">
                        <label for="spd">스테디 셀러</label><br>
                        <input type="checkbox" id="rpd" name="pd_chr_cd" value="R">
                        <label for="rpd">추천 제품</label><br>
                        <input type="hidden" name="pd_chr_cd" value="">
                    </td>
                </tr>
            </table>
            <input type="hidden" name="productList" value="${productList}">
            <input type="hidden" name="selectedContent" value="${selectedContent}">
        </div>
        <div class="buttons">
            <button type="submit" class="registerBtn" id="registerBtn">선택항목 일괄변경</button>
            <button type="button" class="cancelBtn" id="cancelBtn">취소</button>
        </div>
    </form>
    </div>
</div>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
    console.log("pd_chr_cd")
    $(document).ready(function() {
        /*입력한 값의 앞, 뒤에 있는 공백 제거*/
        $("input").on('blur', function () {
            $(this).val($.trim($(this).val()));
        });

        /*전체 선택을 클릭하는 경우 발생하는 함수*/
        $("#selectAll").click(function() {
            /*전체 선택이 체크되어 있다면 나머지 체크박스도 체크되게 한다.*/
            if($("#selectAll").is(":checked")) $("input[name=selectedContent]").prop("checked", true);
            /*그렇지 않다면 나머지 체크박스가 체크되지 않게 한다.*/
            else $("input[name=selectedContent]").prop("checked", false);
        });

        /*체크 박스 하나만을 선택했을 때 발생하는 함수*/
        $("input[name=selectedContent]").click(function() {
            /*total에 체크박스의 전체 개수를 저장한다.*/
            let total = $("input[name=selectedContent][type=checkbox]").length;
            /*checked에 체크가 된 체크박수의 개수를 저장한다.*/
            let checked = $("input[name=selectedContent]:checked").length;

            /*전체 체크박스의 수와 체크된 체크박스의 개수가 다르면 전체 선택이 체크되지 않게 한다.*/
            if(total != checked) $("#selectAll").prop("checked", false);
            /*전체 체크박스의 수와 체크된 체크박스의 개수가 동일하다면 전체 선택이 체크되게 한다.*/
            else $("#selectAll").prop("checked", true);
        });

        /*아무것도 선택하지 않았으면 값을 입력해달라고 경고창 띄우기*/
        $("#registerBtn").on("click",function(event){
            let checked = $("input[name=selectedContent]:checked").length;
            if (checked == 0) {
                alert("하나 이상의 항목을 선택해주세요.");
                event.preventDefault();
            }
        });

        /*선택된 항목들의 데이터를 저장할 selectedContent를 선언한다.*/
        let selectedContent = {};
        /*name 속성이 selectedContent인 체크박스를 반복한다.*/
        $('input:checkbox[name="selectedContent"]').each(function() {
            /*만약 체크박스가 체크되어 있다면*/
            if (this.checked) {
                /*체크된 체크박스의 id속성을 키로 사용하여 selectedContent 객체에 값을 추가한다.*/
                /*이 때 해당 id를 가진 라디오 버튼 중 체크된 값(value)을 가져와서 저장한다.*/
                selectedContent[$(this).attr('id')] = $('input[name="' + $(this).attr('id') + '"]:checked').val();
            }
        });
    });

    // 취소 버튼 클릭하면 뒤로 가기
    document.getElementById("cancelBtn").addEventListener("click", function() {
        window.history.back();
    });
</script>
</body>
</html>