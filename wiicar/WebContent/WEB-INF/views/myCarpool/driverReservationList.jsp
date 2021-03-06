<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
	<style>
		#content {
		  width: 100%;
		  height: 100%;
		  background-color: #fff;
		  background-image: none;
		  display: flex;
		}
				
		#driver, #passenger {
		  padding: 2% 3%;
		  width: 49%;
		  border-radius: 30px;
		  font-size: 18px;
		  font-weight: 900;
		  color: #fff;
		}
		
		#driver {
		  float: left;
		  background-color:cornflowerblue;
		}
		
		#passenger {
		  float:right;
		  color : #000000;
		  background-color: transparent;
		  border: 1px solid #eee;
		}
		#passenger:hover {
			  background-color: #eee;
			}
		.carpool_list {
		  clear:both;
		  width: 100%;
		  padding-top: 20px;
		  margin: 0 auto;
		  position:relative;
		  text-align: center;
		}
		.list_btn {
		  display: inline-block;
		  margin: 0 auto;
		}
		.list_btn button {
		  background-color: transparent;
		  border: 1px solid #eee;
		  width: 200px;
		  margin: 0 auto;
		  padding:15px;
		  border-radius: 20px;
		}
		.list_btn button:hover {
		  background-color: #eee;
		}
		.list_content {
		  padding-top: 30px;
		}
	</style>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<link href="/wiicar/resources/css/styles.css" rel="stylesheet"type="text/css" />
	<link href="/wiicar/resources/css/memberMenu.css" rel="stylesheet"type="text/css" />
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script>
		// allData ??????????????? ??????
		function btn(data){
			var datajson = new Object;
			datajson.passenger = $("input[name=passenger]").val()
			datajson.carpoolnum = $("input[name=carpoolNum]").val()
			datajson.driver = $("input[name=driver]").val()
			datajson.roomnum = $("input[name=roomnum]").val()
			var alldata = JSON.stringify(datajson);
			if(data === 'accept') {accept(alldata);}
			if(data === 'refuse') {refuse(alldata);}			
		}

		//???????????? ???
		function accept(alldata) {
			console.log("accept?????? ??????");
		   // ??????????????? ????????????(1) / ?????????????????? +1 / 
		   // ??????????????? ????????? ???????????????~~~!
		   // ????????????????????? ??????(1) -> ??????????????? ???????????? ????????? ?????????(ALERTS ?????????)
		   $.ajax({
		      url : "/wiicar/carpool/accept.do",
		      type : "POST",
		      data : alldata,
		      contentType: "application/json;charset=utf-8",
		      success : function(data) {
		    	 console.log("** ?????? ??????");
		    	 alert('?????? ????????? ?????????????????????!');
		         location.reload();
		      },
		      error:function(request, status, error){
				console.log("??????");
		         console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      }
		   })
		}
		// ???????????? ???
		function refuse(alldata) {
		   // ????????????????????? ??????(2) -> ??????????????? ?????? ????????? ?????????(ALERTS ?????????)
		   $.ajax({
		      url : "/wiicar/carpool/refuse.do",
		      type : "POST",
		      data : alldata,
		      contentType: "application/json;charset=utf-8",
		      success : function(data) {
		         console.log("** ?????? ??????");
		         alert('?????? ????????? ?????????????????????!');
		         location.reload();
		      },
		      error:function(request, status, error){
		         console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		      }
		   })
		}
	</script>
</head>
<body style="overflow-y:auto;margin-top:30px;">
<div id="container" class="memberContainer">
	<jsp:include page="/WEB-INF/views/header.jsp"></jsp:include>
	<div id="content">
		<div id="sidebar">
			<jsp:include page="/WEB-INF/views/member/memberMenu.jsp" />
		</div>
		<div id="mypage">
		 <div class="mypageContent">
	    	<div class="content">
	      		<button id="driver" onclick="location.href='/wiicar/member/driverReserv.do'">?????????</button>
	      		<button id="passenger" onclick="location.href='/wiicar/member/passangerMyCarpool.do?sort=reservation'">?????????</button>
				<div class="carpool_list">
					<div class="list_btn">
		          		<button class="waiting" onclick="location.href='/wiicar/member/driverReserv.do'">?????? ?????????</button>
		          		<button class="schedule" onclick="location.href='/wiicar/member/driverUpComming.do'">????????? ??????</button>
		          		<button class="past"onclick="location.href='/wiicar/member/driverPast.do'">?????? ??????</button>
					</div>
					<div>
						<c:if test="${listSize <= 0}">
						?????? ?????? ????????? ????????????.
						</c:if>
						<c:if test="${listSize > 0}">
							<c:forEach var="i" begin="0" end="${listSize-1}">
								<div style="margin-top:20px;">
									<div style="margin:auto;width:600px;background-color:#ffffff;border-radius:10px;box-shadow:5px 5px 1px 1px gray;">
										<div style="padding-top:20px;">
											<div style="margin-left:20px;font-size:20px;">
												<span>????????? : ${carpoolInfo[i].depart}  <br/></span>
												<span>????????? : ${carpoolInfo[i].destination}</span>
											</div>
											<div style="margin-left:20px;margin-top:10px;font-size:15px;">
												<div>${carpoolInfo[i].time}</div>
												<div style="margin-left:auto;margin-right:20px;">?????? : ${carpoolInfo[i].price}???</div>
											</div>
											<div style="display:flex;margin-left:20px;margin-top:10px;">
												<div style="margin-right:20px;margin-left:auto;">

														<input type="hidden"  name="passenger" value="${passangerNickname[i]}" />
														<input type="hidden" name="carpoolNum" value="${carpoolInfo[i].carpoolNum}" />
														<input type="hidden" name="driver" value="${carpoolInfo[i].driverId}" />
														<input type="hidden" name="roomnum" value="${roomNum[i]}" />
														<button id="accept" class="requestBtn" onclick="btn('accept');" style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" >??????</button>
														<button id="refuse" class="requestBtn" onclick="btn('refuse');" style="border:none;border-radius:5px;width:120px;height:30px;color:white;background-color:#3498DB;" >??????</button>
													</div> 
											</div>
											<div style="display:flex; margin:auto; margin-top:20px;">
												<div style="text-align:center; margin-left:20px;">
													<div style="margin-bottom:5px; color:#3498D8;font-weight:700;">?????? ????????? ??????</div>
													<div>
														<c:if test="${passangerImage[i] == null}" >
															<img class="userImg" src="/wiicar/resources/imgs/profile_default.png" alt="${passangerImage[i]}" style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
														<c:if test="${passangerImage[i] != null}" >
															<img class="userImg" src="/wiicar/resources/imgs/${passangerImage[i]}" alt="${passangerImage[i]}"  style="width:100%;max-width:75px;border-radius:50%;">
														</c:if>
													</div>
												</div>
												<div style="width:120;margin-left:10px;margin-bottom:0px;margin-top:5%;">
													<div>${passangerNickname[i]}</div>
													<div style="display:flex;vertical-align:middle;height:30px;">
														<div style="margin-top:2px;">??????&nbsp;&nbsp;</div>
														<div>
															<c:forEach begin="1" end="${rate[i] / 1}">
																<img src="/wiicar/resources/imgs/star.png" style="width:20px" />
															</c:forEach>
															<c:if test="${(rate[i] % 1) == 0.5}">
																<img src="/wiicar/resources/imgs/halfstar.png" style="width:20px" />
															</c:if>
														</div>
													</div>
												</div>
												<div style="margin-left:auto;width:50%;">
													<div style="margin-bottom:5px;color:#3498D8;font-weight:700;">???????????? ?????????</div>
													<div style="display:flex;">
														<div>${reservationList[i].message}</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
	   		</div>
	   </div>
	   </div><!-- mypage -->
	</div>
	<!-- FOOTER -->
	<jsp:include page="/WEB-INF/views/footer.jsp"></jsp:include>
</div>
</body>
</html>