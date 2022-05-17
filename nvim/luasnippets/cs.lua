return {
  s('/sum', fmt('/// <summary>\n///{}\n///</summary>\n', { i(1, 'description') })),
  s('pgs', { t('public '), i(1, 'type'), t(' '), i(2, 'name'), t(' { get; set; }') }),
}
