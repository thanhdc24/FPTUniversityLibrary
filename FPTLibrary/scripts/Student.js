function init() {
    var main = document.getElementsByClassName("mainDiv");
    main[0].style.minHeight = window.innerHeight + "px";
}
        xSlideShow = 0;
		function runSlideShow () {
			tag = document.getElementsByClassName("imgContainer");
			tag[0].style.transform = "translateX(-" + xSlideShow + "%)";
			tag[0].style.transition = "transform 1.5s";
			xSlideShow += 20;
			if (xSlideShow > 80) {
				xSlideShow = 0;
			}
			setTimeout("runSlideShow()",10000);
		}

		function viewProduct (idProduct) {

			tag = document.getElementById("productBox");
			tag.src = "/layoutImages/product/" + idProduct + "/product.html";
			// alert(tag.src);

			tag = document.getElementsByClassName("productViewer");
			if (window.innerWidth >= 900) {
				tag[0].style.height = '562.5px';
				tag[0].style.width = '1000px';
			} else {
				tag[0].style.height = (window.innerWidth-40)/16*9 + "px";
				tag[0].style.width = (window.innerWidth-40) + "px";
			}


			tag[0].style.transition = 'all 1s';
			var main = document.getElementsByClassName("mainDiv");
			main[0].style.opacity = '0.4';
		}

		function closeProduct () {
			tag = document.getElementsByClassName("productViewer");
			
			tag[0].style.height = '0px';
			tag[0].style.width = '0px';
			tag[0].style.transition = 'all 0.5s';
			main = document.getElementsByClassName("mainDiv");
			main[0].style.opacity = '1';
		}
