state("At Worlds End") {
	byte lstart : 0x003D5C78;
	byte not_in_story : 0x003D8B21;
}

init {
	vars.lnumber = 0;
	vars.is_load = false;
	vars.is_split = false;
	vars.is_start = false;
}

start {
	vars.lnumber = 0;
	vars.is_start = true;
	return current.not_in_story == 0;
}

update {
	if (current.lstart != old.lstart) {
		bool load = old.lstart == 0;
		if (load ^ (vars.lnumber == 45)) { // second for the end of game
			vars.lnumber++;
			vars.is_split = true;
		}
		vars.is_load = load;
		return true;
	}
	if (vars.is_start) {
		vars.is_start = false;
		return true;
	}
	return false;
}

isLoading {
	return vars.is_load;
}

split {
	if (vars.is_split) {
		vars.is_split = false;
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
			case 46: // last cutscene (end) (45 load + 1 for end of load)
				return true;
			
			default:
				break;
		}
	}
	return false;
}

reset {
	return current.not_in_story == 1;	
}
