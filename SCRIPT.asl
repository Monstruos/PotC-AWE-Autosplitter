state("At Worlds End") {
	byte lstart : 0x003D5C78;
}

init {
	vars.lnumber = 0;
	vars.is_load = false;
	vars.is_start = false;
}

update {
	if (current.lstart != old.lstart) {
		bool load = old.lstart == 0;
		if (load) {
			vars.lnumber++;
		}
		vars.is_load = load;
		return true;
	}
	if (vars.is_start) {
		return true;
	}
	return false;
}

isLoading {
	vars.is_start = false;
	return vars.is_load;
}

split {
	if (current.lstart != old.lstart) {
		if (old.lstart == 0) {
			Int32 num = vars.lnumber;
			switch(num) {
				case 3: // Pelegostos
				case 6: // Port Royal
				case 9: // Dutchman
				case 12: // Tortuga
				case 17: // Isla Cruces
				case 21: // Kraken
				case 24: // Singapore
				case 29: // DDL
				case 33: // Empress
				case 38: // SC
				case 41: // Maelstorm
					return true;
				
				default:
					break;
			}
		} else {
			if (vars.lnumber == 45) { // end of game
				return true;
			}
		}
	}
	return false;
}

start {
	vars.lnumber = 0;
	vars.is_start = true;
	return true;
}
