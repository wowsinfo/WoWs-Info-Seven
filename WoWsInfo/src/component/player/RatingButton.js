/**
 * RatingButton.js
 * 
 * A button displaying rating
 */

import React, { Component } from 'react';
import { Button } from 'react-native-paper';
import { getColour, getComment, SafeAction } from '../../core';

class RatingButton extends Component {
  render() {
    const { rating, number } = this.props;

    if (number) {
      return (
        <Button mode='contained' color={getColour(rating)}>
          {rating}
        </Button>
      );
    } else {
      if (rating == null || rating === 0) return null;
      return (
        <Button mode='contained' color={getColour(rating)} onPress={() => SafeAction('Rating')}>
          {getComment(rating)}
        </Button>
      );
    }
  };
}

export { RatingButton };
