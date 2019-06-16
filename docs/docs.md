<h3><b>img2ballz</b></h3>
	convert images to a hemispherical map of ballz<br>
	useful for paintball tattoos<br>
	paste results into [Paint Ballz]
	<br><br>
<div style="margin-left: 40px">
	<b>images</b>
		<ul>
			<li>drag and drop a .png into the slot from a folder, it should appear in the slot</li>
			<li>you should prepare images so they only use colours from the petz palette (found in the palette folder of pastylabz)</li>
			<li>alpha and colours not on the palette won't produce any ballz</li>
			<li>try to keep your image towards the centre and avoid having pixels right on the edge to avoid distortion</li>
		</ul>
	<b>rotation and spacing</b>
		<ul>
			<li>spacing sets the spacing between coordinates produced. this does nothing with paintballz because their coordinates are used as a direction</li>
			<li>rotation uses aircraft terms (roll, pitch, yaw) and is in degrees</li>
			<li><image src="rotationguide.png"></li>
		</ul>
	<b>wrapping</b>
		<ul>
			<li>the lines of coordinates and colours must be wrapped in ball information to be useful</li>
			<li>the paintballz tab allows you to set the parent to attach the paintballz to, and the size of the paintballz as percentage of parent size</li>
			<li>the custom tab allows you to type in custom text to wrap the lines in, so you can manually add information like textures and fuzz</li>
		<li>remember to convert the image to coords and colours again before re-wrapping</li>
		</ul>
</div><br><br>

<h3><b>haloz</b></h3>
	create regular shapes / circles of ballz and linez<br>
	useful for halos/rings<br>
	<br>
<div style="margin-left: 40px">
	<b>base and start ball</b>
		<ul>
			<li>the base ball is the parent / the ball the halo will be attached to</li>
			<li>the start ball is what the id of the first ball of the halo will be in the lnz file - this is needed to connect the linez</li>
			<li>you can find what the start ball by counting from the last commented ball id in the file, such as ";ears 80"</li>
			<li>it is good practice to comment your ball id for the start of each chunk of your addball section to keep track</li>
			<li>if your halo comes out broken, you will need to correct the start ball id and create the connecting linez again</li>
		</ul>
	<b>rotation and distance</b>
		<ul>
			<li>distance is applied after rotation, moving the halo in the direction it is facing after being rotated</li>
			<li>haloz start facing the direction the pet is facing, like with img2ballz</li>
			<li>rotation uses aircraft terms (roll, pitch, yaw) and is in degrees</li>
			<li><image src="rotationguide.png"></li>
		</ul>
	<b>size and resolution</b>
		<ul>
			<li>ball size is the size of the ballz that make up the ring/halo</li>
			<li>ring size is the size of the ring/halo itself - a size 100 ring will fit snugly to a size 100 ball</li>
			<li>resolution is the number of ballz in the halo - 3 will produce a triangle, 4 a square, and so on</li>
			<li>higher resolutions will produce smoother circles, but be wary of the limit of ballz and linez per pet (around 500 for each)</li>
		</ul>
	<b>color/colour/cooulloororuuurr</b>
		<ul>
			<li>use the ColorChart in the palette folder to find colour id - the palette in Pet Workshop can be inaccurate</li>
		</ul>
</div><br><br>

<h3><b>texswaplist</b></h3>
	exhaustively make a million texture swap variations by defining what textures are allowed in each slot<br>
	kind of simulates randomly selecting textures per slot<br>
	put it in [Texture List]<br>
	this one scares me<br>
	<br>
<div style="margin-left: 40px">
	<b>base texture list</b>
		<ul>
			<li>here you put a list of all the textures in your file, with the argument for colour type on the end</li>
			<li>the line numbers will be how you refer to each texture when you create your slots</li>
		</ul>
	<b>texture slots</b>
		<ul>
			<li>define which textures are allowed in each slot by listing their line number in the base list, comma separated</li>
			<li>each line here is a slot for a texture, which can be referred to by ballz and linez in your lnz file</li>
			<li>(note that the line numbers in the slots zone here start at 1, while while lnz files refer to the first texture as 0)</li>
			<li>(i couldnt easily get the line numbers to start at 0, sorry!)</li>
		</ul>
	<b>permutations</b>
		<ul>
			<li>when you create the big nasty list, it will stop at the maximum permutations number</li>
			<li>if youre making an absurd number of variations and spreading them across files in chunks, you can set what # to start at</li>
		</ul>
</div><br><br>

<br><br>
<br><br>