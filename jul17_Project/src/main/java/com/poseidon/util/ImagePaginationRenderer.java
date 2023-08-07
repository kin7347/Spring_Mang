package com.poseidon.util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class ImagePaginationRenderer extends AbstractPaginationRenderer {
 
	public ImagePaginationRenderer() {
		firstPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><image src=\"./img/page_pprev.png\" border=0/></a>&#160;"; 
		previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><image src=\"./img/page_prev.png\" border=0/></a>&#160;";
		currentPageLabel = "<a style= color:red ;><strong>{0}</strong></a>&#160;";
		otherPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>&#160;";
		nextPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><image src=\"./img/page_next.png\" border=0/></a>&#160;";
		lastPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><image src=\"./img/page_nnext.png'\" border=0/></a>&#160;";
	}
}
