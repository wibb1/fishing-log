import React from 'react';
import { render } from 'react-dom';

import App from '../react/components/App';
import RedBox from 'redbox-react';

document.addEventListener('DOMContentLoaded', () => {
	let reactElement = document.getElementById('app');

	if (reactElement) {
		if (window.railsEnv && window.railsEnv === 'development') {
			try {
				render(<App />, reactElement);
			} catch (e) {
				render(<RedBox error={e} />, reactElement);
			}
		} else {
			render(<App />, reactElement);
		}
	}

	const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll(`.navbar-burger`), 0);

	if ($navbarBurgers.length > 0) {
		$navbarBurgers.forEach((element) => {
			element.addEventListener(`click`, () => {
				const target = element.dataset.target;
				const $target = document.getElementById(target);
				element.classList.toggle(`is-active`);
				$target.classList.toggle(`is-active`);
			});
		});
  }

  // Get all "navbar-burger" elements
  const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll(`.navbar-burger`), 0);

  // Check if there are any navbar burgers
  if ($navbarBurgers.length > 0) {

    // Add a click event on each of them
    $navbarBurgers.forEach( element => {
      element.addEventListener(`click`, () => {

        // Get the target from the "data-target" attribute
        const target = element.dataset.target;
        const $target = document.getElementById(target);
        // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
        element.classList.toggle(`is-active`);
        $target.classList.toggle(`is-active`);
      });
    });
  };
})
