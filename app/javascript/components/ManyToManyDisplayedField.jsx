import React from "react"
import PropTypes from "prop-types"
class ManyToManyDisplayedField extends React.Component {
  render () {
    return (
      <span title="{this.props.title}" data-displayed_field>{this.props.text}</span>
    );
  }
}

ManyToManyDisplayedField.propTypes = {
  title: PropTypes.string,
  text: PropTypes.string
};
export default ManyToManyDisplayedField
