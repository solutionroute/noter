const purgecss = require('@fullhuman/postcss-purgecss')
const cssnano = require('cssnano')
module.exports = {
    plugins: [
        require('tailwindcss'),
        require('autoprefixer'),
        cssnano({
            preset: 'default',
            discardComments: {
                removeAll: true,
            },
        }),
        purgecss({
            content: ['./http/**/*.html', './http/**/*.vue', './http/**/*.jsx'],
            defaultExtractor: content => content.match(/[\w-/:]+(?<!:)/g) || []
        })
    ]
}
