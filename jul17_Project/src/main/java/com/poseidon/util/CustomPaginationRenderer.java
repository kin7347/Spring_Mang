package com.poseidon.util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class CustomPaginationRenderer extends AbstractPaginationRenderer {
	 
	public CustomPaginationRenderer() {
		firstPageLabel 		= "<li><a href=\"#\" class=\"first\" onclick=\"{0}({1}); return false;\">처음으로</a></li>";
        previousPageLabel 	= "<li><a href=\"#\" class=\"prev\" onclick=\"{0}({1}); return false;\">이전으로</a></li>";
        currentPageLabel 	= "<li><a href=\"#\" class=\"active\">{0}</a></li>";
        otherPageLabel 		= "<li><a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a></li>";
        nextPageLabel	 	= "<li><a href=\"#\" class=\"next\" onclick=\"{0}({1}); return false;\">다음으로</a></li>";
        lastPageLabel 		= "<li><a href=\"#\" class=\"last\" onclick=\"{0}({1}); return false;\">맨뒤로</a></li>";
	}
}
