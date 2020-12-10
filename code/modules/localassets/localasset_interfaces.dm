
/// for PaperSheet
/datum/asset/basic/paper
	local_assets = list(
		"stamp-clown.png",
		"stamp-deny.png",
		"stamp-ok.png",
		"stamp-hop.png",
		"stamp-md.png",
		"stamp-ce.png",
		"stamp-hos.png",
		"stamp-rd.png",
		"stamp-cap.png",
		"stamp-qm.png",
		"stamp-law.png",
		"stamp-chap.png",
		"stamp-mime.png",
		"stamp-centcom.png",
		"stamp-syndicate.png",
		"stamp-void.png"
	)

	init()
		. = ..()
		url_map = list(
			"stamp-sprite-clown" = "[resource("images/tg/stamp-clown.png")]",
			"stamp-sprite-deny" = "[resource("images/tg/stamp-deny.png")]",
			"stamp-sprite-ok" = "[resource("images/tg/stamp-ok.png")]",
			"stamp-sprite-hop" = "[resource("images/tg/stamp-hop.png")]",
			"stamp-sprite-md" = "[resource("images/tg/stamp-md.png")]",
			"stamp-sprite-ce" = "[resource("images/tg/stamp-ce.png")]",
			"stamp-sprite-hos" = "[resource("images/tg/stamp-hos.png")]",
			"stamp-sprite-rd" = "[resource("images/tg/stamp-rd.png")]",
			"stamp-sprite-cap" = "[resource("images/tg/stamp-cap.png")]",
			"stamp-sprite-qm" = "[resource("images/tg/stamp-qm.png")]",
			"stamp-sprite-law" = "[resource("images/tg/stamp-law.png")]",
			"stamp-sprite-chap" = "[resource("images/tg/stamp-chap.png")]",
			"stamp-sprite-mime" = "[resource("images/tg/stamp-mime.png")]",
			"stamp-sprite-centcom" = "[resource("images/tg/stamp-centcom.png")]",
			"stamp-sprite-syndicate" = "[resource("images/tg/stamp-syndicate.png")]",
			"stamp-sprite-void" = "[resource("images/tg/stamp-void.png")]"
		)
