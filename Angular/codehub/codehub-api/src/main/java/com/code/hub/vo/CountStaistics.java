package com.code.hub.vo;

/**
 * Represent count related statistics
 * 
 * @author tbhakre
 *
 */
public class CountStaistics {

	private String key;
	private Long count;

	public CountStaistics(String key, Long count) {
		this.key = key;
		this.count = count;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public Long getCount() {
		return count;
	}

	public void setCount(Long count) {
		this.count = count;
	}

}
