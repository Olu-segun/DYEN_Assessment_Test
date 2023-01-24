const displayedImage = document.querySelector('.displayed-img');
const thumbBar = document.querySelector('.thumb-bar');

const btn = document.querySelector('button');
const overlay = document.querySelector('.overlay');



/* Looping through images */
for (let i = 1; i <= 5; i++){
	let Source = 'images/pic' + [i] + ".jpg";

	const newImage = document.createElement('img');
	let Src = newImage.setAttribute('src', Source);
	thumbBar.appendChild(newImage);

	newImage.addEventListener('click', function() {
		let newSrc = displayedImage.setAttribute('src', Source);
		
	})
}

/* Wiring up the Darken/Lighten button */

btn.addEventListener('click', function() {
	
	if (btn.textContent === "Darken") {
		btn.textContent = "Lighten";
		btn.setAttribute('class', 'dark');
		overlay.style.backgroundColor = "rgba(0,0,0,0.5)";


	} else if (btn.textContent === "Lighten") {
		btn.textContent = "Darken";
		overlay.style.backgroundColor = "rgba(0,0,0,0)";
		
	}				
})